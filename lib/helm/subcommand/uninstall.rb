require_relative "base"

module Helm
  module Subcommand
    ## Helm uninstall subcommand: `helm uninstall RELEASE_NAME [...] [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_uninstall/
    class Uninstall < Base
      attr_reader :release_name

      def initialize(release_name, options = {})
        super(options)

        @release_name = release_name
      end

      def subcommand_name
        "uninstall"
      end

      def subcommand
        "uninstall #{release_name} #{flags}"
      end

      def cli_options
        {}.tap do |options|
        end
      end
    end
  end
end
