require_relative 'base'

module Rhelm
  module Subcommand
    ## Helm uninstall subcommand: `helm uninstall RELEASE_NAME [...] [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_uninstall/
    class Uninstall < Base
      attr_reader :release_name,
                  :description,
                  :dry_run,
                  :help,
                  :keep_history,
                  :no_hooks,
                  :timeout

      def initialize(release_name, options = {})
        super(options)

        @release_name = release_name
        @description = options[:description]
        @dry_run = options[:dry_run]
        @help = options[:help]
        @keep_history = options[:keep_history]
        @no_hooks = options[:no_hooks]
        @timeout = options[:timeout]
      end

      def subcommand_name
        'uninstall'
      end

      def cli_args
        super.tap do |args|
          args << ['--description', description] if description
          args << '--dry-run' if dry_run
          args << '--help' if help
          args << '--keep-history' if keep_history
          args << '--no-hooks' if no_hooks
          args << ['--timeout', timeout] if timeout
          args << release_name
        end.flatten
      end
    end
  end
end
