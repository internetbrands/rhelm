require_relative "base"

module Helm
  module Subcommand
    ## Helm status subcommand: `helm status RELEASE_NAME [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_status/
    class Status < Base
      attr_reader :release_name,
                  :help

      def initialize(release_name, options = {})
        super

        @release_name = release_name
        @help = options[:help]
      end

      def subcommand_name
        "status"
      end

      def subcommand
        "status #{release_name} #{flags}"
      end

      def cli_options
        super.tap do |options|
          options[:help] = "--help" if help
        end
      end
    end
  end
end
