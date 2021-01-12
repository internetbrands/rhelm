require_relative "base"

module Helm
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

      def subcommand
        "history #{release_name} #{flags}"
      end

      def cli_options
        super.tap do |options|
          options[:help] = "--help" if help
          options[:max] = "--max #{max}" if max
          options[:output] = "--output #{output}" if output
        end
      end
    end
  end
end
