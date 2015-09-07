require 'vagrant'

module VagrantPlugins
  module DnsUpdater
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :provider
      attr_accessor :appkey
      attr_accessor :appsecret
      attr_accessor :consumerkey
      attr_accessor :zone
      attr_accessor :subdomain
      attr_accessor :interface
      attr_accessor :ttl


      def initialize
        @provider = UNSET_VALUE
        @appkey = UNSET_VALUE
        @appsecret = UNSET_VALUE
        @consumerkey = UNSET_VALUE
        @zone = UNSET_VALUE
        @subdomain = UNSET_VALUE
        @interface = UNSET_VALUE
        @ttl = UNSET_VALUE
      end

      def finalize!
        @provider = nil if @provider == UNSET_VALUE
        @appkey = nil if @appkey == UNSET_VALUE
        @appsecret = nil if @appsecret == UNSET_VALUE
        @consumerkey = nil if @consumerkey == UNSET_VALUE
        @zone = nil if @zone == UNSET_VALUE
        @subdomain = nil if @subdomain == UNSET_VALUE
        @interface = nil if @interface == UNSET_VALUE
        @ttl = 60 if @ttl == UNSET_VALUE
      end

      def validate(machine)
        finalize!
        errors = []
        errors << 'provider parameter is required with a valid value' unless ['ovh'].include?(@provider)
        errors << 'appkey parameter is required' if @appkey.nil? && @provider == 'ovh'
        errors << 'appsecret parameter is required' if @appsecret.nil? && @provider == 'ovh'
        errors << 'consumerkey parameter is required' if @consumerkey.nil? && @provider == 'ovh'
        errors << 'zone parameter is required' if @zone.nil?
        errors << 'subdomain parameter is required' if @subdomain.nil?
        errors << 'interface parameter is required' if @interface.nil?

        { "DnsUpdater" => errors }
      end
    end

  end
end