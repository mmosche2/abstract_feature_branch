# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "abstract_feature_branch"
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Annas \"Andy\" Maleh"]
  s.date = "2014-01-14"
  s.description = "abstract_feature_branch is a Rails gem that enables developers to easily branch by abstraction as per this pattern:\nhttp://paulhammant.com/blog/branch_by_abstraction.html\n\nIt is a productivity and fault tolerance enhancing team practice that has been utilized by professional software development\nteams at large corporations, such as Sears and Groupon.\n\nIt provides the ability to wrap blocks of code with an abstract feature branch name, and then\nspecify in a configuration file which features to be switched on or off.\n\nThe goal is to build out upcoming features in the same source code repository branch, regardless of whether all are\ncompleted by the next release date or not, thus increasing team productivity by preventing integration delays.\nDevelopers then disable in-progress features until they are ready to be switched on in production, yet enable them\nlocally and in staging environments for in-progress testing.\n\nThis gives developers the added benefit of being able to switch a feature off after release should big problems arise\nfor a high risk feature.\n\nabstract_feature_branch additionally supports DDD's pattern of\nBounded Contexts by allowing developers to configure\ncontext-specific feature files if needed.\n"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".coveralls.yml",
    ".travis.yml",
    "LICENSE.txt",
    "README.md",
    "RELEASE_NOTES.md",
    "VERSION",
    "abstract_feature_branch.gemspec",
    "config/features/admin.local.yml",
    "config/features/admin.yml",
    "config/features/internal/wiki.local.yml",
    "config/features/internal/wiki.yml",
    "config/features/public.local.yml",
    "config/features/public.yml",
    "lib/abstract_feature_branch.rb",
    "lib/abstract_feature_branch/file_beautifier.rb",
    "lib/ext/feature_branch.rb",
    "lib/generators/abstract_feature_branch/context_generator.rb",
    "lib/generators/abstract_feature_branch/install_generator.rb",
    "lib/generators/templates/config/features.example.yml",
    "lib/generators/templates/config/features.local.yml",
    "lib/generators/templates/config/features.yml",
    "lib/generators/templates/config/initializers/abstract_feature_branch.rb",
    "lib/generators/templates/lib/tasks/abstract_feature_branch.rake",
    "ruby187.Gemfile",
    "ruby187.Gemfile.lock",
    "spec/abstract_feature_branch/file_beautifier_spec.rb",
    "spec/ext/feature_branch__feature_branch_per_user_spec.rb",
    "spec/ext/feature_branch__feature_branch_spec.rb",
    "spec/ext/feature_branch__feature_enabled_spec.rb",
    "spec/fixtures/application_development_config/config/features.reference.yml",
    "spec/fixtures/application_no_config/no_config",
    "spec/fixtures/application_rails_config/config/features.local.yml",
    "spec/fixtures/application_rails_config/config/features.yml",
    "spec/fixtures/application_ugly_config_reference/config/another_application_configuration.yml",
    "spec/fixtures/application_ugly_config_reference/config/database.yml",
    "spec/fixtures/application_ugly_config_reference/config/features.local.yml",
    "spec/fixtures/application_ugly_config_reference/config/features.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/admin.local.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/admin.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/empty.local.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/feature_empty_config.local.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/including_comments.local.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/internal/wiki.local.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/internal/wiki.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/public.local.yml",
    "spec/fixtures/application_ugly_config_reference/config/features/public.yml"
  ]
  s.homepage = "http://github.com/AndyObtiva/abstract_feature_branch"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.6"
  s.summary = "abstract_feature_branch is a Rails gem that enables developers to easily branch by abstraction as per this pattern: http://paulhammant.com/blog/branch_by_abstraction.html"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<deep_merge>, ["= 1.0.0"])
      s.add_runtime_dependency(%q<redis>, ["~> 3.0.0"])
      s.add_development_dependency(%q<jeweler>, ["= 1.8.8"])
    else
      s.add_dependency(%q<deep_merge>, ["= 1.0.0"])
      s.add_dependency(%q<redis>, ["~> 3.0.0"])
      s.add_dependency(%q<jeweler>, ["= 1.8.8"])
    end
  else
    s.add_dependency(%q<deep_merge>, ["= 1.0.0"])
    s.add_dependency(%q<redis>, ["~> 3.0.0"])
    s.add_dependency(%q<jeweler>, ["= 1.8.8"])
  end
end

