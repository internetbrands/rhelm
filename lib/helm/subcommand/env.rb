require_relative "base"

module Helm
  module Subcommand
    ## Helm env subcommand: `helm env [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_env/
    class Env < Base
      attr_reader :help

      def initialize(options = {})
        super

        @help = options[:help]
      end

      def subcommand_name
        "env"
      end

      def subcommand
        "env #{flags}"
      end

      def cli_options
        super.tap do |options|
          options[:help] = "--help" if help
        end
      end
    end
  end
end
