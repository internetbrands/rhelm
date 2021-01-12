require_relative "base"

module Rhelm
  module Subcommand
    ## Helm history subcommand: `helm history RELEASE_NAME [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_history/
    class History < Base
      attr_reader :release_name,
                  :help,
                  :max,
                  :output

      def initialize(release_name, options = {})
        super(options)

        @release_name = release_name
        @help = options[:help]
        @max = options[:max]
        @output = options[:output]
      end

      def subcommand_name
        "history"
      end

      def cli_args
        super.tap do |args|
          args << "--help" if help
          args << [ '--max', max ] if max
          args << [ '--output', output ] if output

          args << release_name
        end.flatten
      end
    end
  end
end
