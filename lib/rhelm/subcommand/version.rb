require_relative "base"

module Rhelm
  module Subcommand
    ## Helm version subcommand: `helm version [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_version/
    class Version < Base
      attr_reader :help,
                  :short,
                  :template

      def initialize(options = {})
        super

        @help = options[:help]
        @short = options[:short]
        @template = options[:template]
      end

      def subcommand_name
        "version"
      end

      def cli_args
        super.tap do |args|
          args << '--help' if help
          args << '--short' if short
          args << ['--template', template] if template
        end.flatten
      end
    end
  end
end
