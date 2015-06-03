# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kantox/marriage/version'

Gem::Specification.new do |spec|
  spec.name          = 'kantox-marriage'
  spec.version       = Kantox::Marriage::VERSION
  spec.authors       = ['Kantox LTD']
  spec.email         = ['aleksei.matiushkin@kantox.com']

  spec.summary       = 'Library to perform matches.'
  spec.description   = 'Matches different numerals basing (currently) on dynamic programming solution of Subset sum problem.
                        See http://en.wikipedia.org/wiki/Subset_sum_problem#Pseudo-polynomial_time_dynamic_programming_solution for details.'
  spec.homepage      = 'http://kantox.com'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(/^(test|spec|features)\//) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = FURY
  end

  # spec.add_dependency 'terminal-table', '~> 1.4'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10'

  spec.add_development_dependency 'rspec', '~> 2.12'
  spec.add_development_dependency 'cucumber', '~> 1.3'
  spec.add_development_dependency 'yard', '~> 0'
end
