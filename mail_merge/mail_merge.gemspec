$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mail_merge/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mail_merge"
  s.version     = MailMerge::VERSION
  s.authors     = ["kohrVid"]
  s.email       = ["kohrVid@zoho.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MailMerge."
  s.description = "TODO: Description of MailMerge."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.rc2"

  s.add_development_dependency "sqlite3"
end
