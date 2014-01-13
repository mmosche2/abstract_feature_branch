require 'rubygems'
require 'bundler'
require 'yaml'
YAML::ENGINE.yamler = "syck" if RUBY_VERSION.start_with?('1.9')
begin
  Bundler.setup(:default)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'logger' unless defined?(Rails) && Rails.logger
require 'deep_merge' unless {}.respond_to?(:deep_merge!)

module AbstractFeatureBranch
  ENV_FEATURE_PREFIX = "abstract_feature_branch_"

  class << self
    def application_root
      @application_root ||= initialize_application_root
    end
    def application_root=(path)
      @application_root = path
    end
    def initialize_application_root
      self.application_root = defined?(Rails) ? Rails.root : '.'
    end
    def application_environment
      @application_environment ||= initialize_application_environment
    end
    def application_environment=(environment)
      @application_environment = environment
    end
    def initialize_application_environment
      self.application_environment = defined?(Rails) ? Rails.env.to_s : ENV['APP_ENV'] || 'development'
    end
    def logger
      @logger ||= initialize_logger
    end
    def logger=(logger)
      @logger = logger
    end
    def initialize_logger
      self.logger = defined?(Rails) && Rails.logger ? Rails.logger : Logger.new(STDOUT)
    end
    def cacheable
      @cacheable ||= initialize_cacheable
    end
    def cacheable=(cacheable)
      @cacheable = cacheable
    end
    def initialize_cacheable
      self.cacheable = {
        :development => false,
        :test => true,
        :staging => true,
        :production => true
      }
    end
    def user_features_storage
      @user_features_storage ||= initialize_user_features_storage
    end
    def user_features_storage=(user_features_storage)
      @user_features_storage = user_features_storage
    end
    def initialize_user_features_storage
      require 'redis'
      self.user_features_storage = Redis.new
    end
    def environment_variable_overrides
      @environment_variable_overrides ||= load_environment_variable_overrides
    end
    def load_environment_variable_overrides
      @environment_variable_overrides = featureize_keys(select_feature_keys(booleanize_values(downcase_keys(ENV))))
    end
    def local_features
      @local_features ||= load_local_features
    end
    def load_local_features
      @local_features = {}
      Dir.glob(File.join(application_root, 'config', 'features', '**', '*.local.yml')).each do |feature_configuration_file|
        @local_features.deep_merge!(downcase_feature_hash_keys(YAML.load_file(feature_configuration_file)))
      end
      main_local_features_file = File.join(application_root, 'config', 'features.local.yml')
      @local_features.deep_merge!(downcase_feature_hash_keys(YAML.load_file(main_local_features_file))) if File.exists?(main_local_features_file)
      @local_features
    end
    def features
      @features ||= load_features
    end
    def load_features
      @features = {}
      Dir.glob(File.join(application_root, 'config', 'features', '**', '*.yml')).each do |feature_configuration_file|
        @features.deep_merge!(downcase_feature_hash_keys(YAML.load_file(feature_configuration_file)))
      end
      main_features_file = File.join(application_root, 'config', 'features.yml')
      @features.deep_merge!(downcase_feature_hash_keys(YAML.load_file(main_features_file))) if File.exists?(main_features_file)
      @features
    end
    # performance optimization via caching of feature values resolved through environment variable overrides and local features
    def environment_features(environment)
      @environment_features ||= {}
      @environment_features[environment] ||= load_environment_features(environment)
    end
    def load_environment_features(environment)
      @environment_features ||= {}
      features[environment] ||= {}
      local_features[environment] ||= {}
      @environment_features[environment] = features[environment].merge(local_features[environment]).merge(environment_variable_overrides)
    end
    def application_features
      unload_application_features unless cacheable?
      environment_features(application_environment)
    end
    def load_application_features
      AbstractFeatureBranch.load_environment_variable_overrides
      AbstractFeatureBranch.load_features
      AbstractFeatureBranch.load_local_features
      AbstractFeatureBranch.load_environment_features(application_environment)
    end
    def unload_application_features
      @environment_variable_overrides = nil
      @features = nil
      @local_features = nil
      @environment_features = nil
    end
    def cacheable?
      value = downcase_keys(cacheable)[application_environment]
      value = (application_environment != 'development') if value.nil?
      value
    end
    def toggle_features_for_user(user_id, features)
      features.each do |name, value|
        user_features_storage.sadd("#{ENV_FEATURE_PREFIX}#{name.to_s.downcase}", user_id) if value
      end
    end

    private

    def featureize_keys(hash)
      Hash[hash.map {|k, v| [k.sub(ENV_FEATURE_PREFIX, ''), v]}]
    end

    def select_feature_keys(hash)
      hash.reject {|k, v| !k.start_with?(ENV_FEATURE_PREFIX)} # using reject for Ruby 1.8 compatibility as select returns an array in it
    end

    def booleanize_values(hash)
      Hash[hash.map {|k, v| [k, v.to_s.downcase == 'true']}]
    end

    def downcase_keys(hash)
      Hash[hash.map {|k, v| [k.to_s.downcase, v]}]
    end

    def downcase_feature_hash_keys(hash)
      Hash[(hash || {}).map {|k, v| [k, v && downcase_keys(v)]}]
    end
  end
end

require File.join(File.dirname(__FILE__), 'ext', 'feature_branch')
require File.join(File.dirname(__FILE__), 'abstract_feature_branch', 'file_beautifier')
