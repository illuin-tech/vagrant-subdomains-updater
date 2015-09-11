# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant-dns-updater/version'

Gem::Specification.new do |spec|
  spec.name          = "vagrant-dns-updater"
  spec.version       = VagrantPlugins::DnsUpdater::VERSION
  spec.authors       = ["Nassim Kacha"]
  spec.email         = ["nassim.kacha@blueicefield.com"]

  spec.description   = 'A Vagrant plugin that allows you to automatically configure a subdomain' \
                       ' with the ip of your vagrant instance using your registrar API.'
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/blueicefield/vagrant-dns-updater"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'ovh-rest', '~> 0.0.5'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
