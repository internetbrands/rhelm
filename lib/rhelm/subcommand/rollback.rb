require_relative "base"

module Rhelm
  module Subcommand
    ## Helm rollback subcommand: `helm rollback <RELEASE> [REVISION] [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_rollback/
    class Rollback < Base
      attr_reader :release,
                  :revision,
                  :cleanup_on_fail,
                  :dry_run,
                  :force,
                  :help,
                  :history_max_int,
                  :no_hooks,
                  :recreate_pods,
                  :timeout_duration,
                  :wait

      def initialize(release, revision, options = {})
        super(options)

        @release = release
        @revision = revision
        @cleanup_on_fail = options[:cleanup_on_fail]
        @dry_run = options[:dry_run]
        @force = options[:force]
        @help = options[:help]
        @history_max_int = options[:history_max_int]
        @no_hooks = options[:no_hooks]
        @recreate_pods = options[:recreate_pods]
        @timeout_duration = options[:timeout_duration]
        @wait = options[:wait]
      end

      def subcommand_name
        "rollback"
      end

      def cli_args
        super.tap do |args|
          args << '--cleanup-on-fail' if cleanup_on_fail
          args << '--dry-run' if dry_run
          args << '--force' if force
          args << '--help' if help
          args << ['--history-max-int', history_max_int] if history_max_int
          args << '--no-hooks' if no_hooks
          args << '--recreate-pods' if recreate_pods
          args << ['--timeout-duration', timeout_duration] if timeout_duration
          args << '--wait' if wait

          args << release
          args << revision
        end.flatten
      end
    end
  end
end
