require 'ovh/rest'

module VagrantPlugins
  module SubdomainsUpdater
    class Command < Vagrant.plugin('2', :command)

      def self.synopsis
        'Get OVH consumer key'
      end

      def execute
        access = {
            "accessRules" => [
                { "method" => "GET", "path" => "/domain/*" },
                { "method" => "POST", "path" => "/domain/*" },
                { "method" => "PUT", "path" => "/domain/*" },
                { "method" => "DELETE", "path" => "/domain/*" },
            ]
        }

        argv = parse_args

        result = OVH::REST.generate_consumer_key(argv, access)

        raise Vagrant::Errors::VagrantError.new, result['message'] if result['message'] == 'Invalid application key'

        puts <<-EOF
        validationUrl: #{result['validationUrl']}
        consumerkey: #{result['consumerKey']}
        EOF

      end


      private


      def parse_args
        opts = OptionParser.new do |o|
          o.banner = 'Usage: vagrant ovh-consumer-key [options] <appkey>'
          o.separator ''

          o.on('-h', '--help', 'Print this help') do
            safe_puts(opts.help)
          end
        end

        args = parse_options(opts)

        if args.length != 1
          safe_puts(opts.help)
          exit 1
        end

        args[0]
        end

    end
  end
end
