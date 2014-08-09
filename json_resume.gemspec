# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_resume/version'

Gem::Specification.new do |spec|
  spec.name          = "json_resume"
  spec.version       = JsonResume::VERSION
  spec.authors       = ["Prateek Agarwal"]
  spec.email         = ["prat0318@gmail.com"]
  spec.description   = %q{json_resume creates pretty resume formats from a .json input file. Currently, it can convert to html, tex, markdown and pdf. Customizing the templates to your own needs is also super easy.}
  spec.summary       = %q{Generates pretty resume formats out of json input file}
  spec.homepage      = "http://github.com/prat0318/json_resume"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = ["json_resume"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "i18n"
  spec.add_dependency "mustache"
  spec.add_dependency "pdfkit"
  spec.add_dependency "rest-client"
  spec.add_dependency "thor"
  spec.add_dependency "wkhtmltopdf-binary"

end
