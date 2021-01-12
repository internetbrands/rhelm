require_relative "base"

module Helm
  module Subcommand
    ## Helm test subcommand: `helm test [RELEASE] [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_test/
    class Test < Base
      attr_reader :release,
                  :help,
                  :logs,
                  :timeout

      def initialize(release, options = {})
        super(options)

        @release = options[:release]
        @help = options[:help]
        @logs = options[:logs]
        @timeout = options[:timeout]
      end

      def subcommand_name
        "test"
      end

      def subcommand
        "test #{release} #{flags}"
      end

      def cli_options
        super.tap do |options|
          options[:help] = "--help" if help
          options[:logs] = "--logs" if logs
          options[:timeout] = "--timeout #{timeout}" if timeout
        end
      end
    end
  end
end
