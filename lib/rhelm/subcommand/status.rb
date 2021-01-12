require_relative "base"

module Rhelm
  module Subcommand
    ## Helm status subcommand: `helm status RELEASE_NAME [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_status/
    class Status < Base
      attr_reader :release_name,
                  :help

      def initialize(release_name, options = {})
        super(options)

        @release_name = release_name
        @help = options[:help]
      end

      def subcommand_name
        "status"
      end

      def exists?
        run(raise_on_error: false) do |lines,status|
          if status == 0
            true
          elsif status == 1 && /Error: release: not found/m.match(lines)
            false
          else
            report_failure(lines, status)
          end
        end
      end

      def cli_args
        super.tap do |args|
          args << '--help' if help

          args << release_name
        end.flatten
      end
    end
  end
end
