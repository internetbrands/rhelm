require_relative "base"

module Rhelm
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

      def cli_args
        super.tap do |args|
          args << release_name
        end
      end
    end
  end
end
