require_relative "base"

module Rhelm
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

      def cli_args
        super.tap do |args|
          args << "--help" if help
        end.flatten
      end
    end
  end
end
