require_relative "base"

module Helm
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

      def subcommand
        "version #{flags}"
      end

      def cli_options
        super.tap do |options|
          options[:help] = "--help" if help
          options[:short] = "--short" if short
          options[:template] = "--template #{template}" if template
        end
      end
    end
  end
end
