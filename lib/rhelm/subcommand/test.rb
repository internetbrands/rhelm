require_relative "base"

module Rhelm
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

      def cli_args
        super.tap do |args|
          args << '--help' if help
          args << '--logs' if logs
          args << ['--timeout', timeout] if timeout

          args << release
        end.flatten
      end
    end
  end
end
