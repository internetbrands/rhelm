require_relative "base"

module Helm
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

      def subcommand
        "rollback #{release} #{revision} #{flags}"
      end

      def cli_options
        super.tap do |options|
          options[:cleanup_on_fail] = "--cleanup-on-fail" if cleanup_on_fail
          options[:dry_run] = "--dry-run" if dry_run
          options[:force] = "--force" if force
          options[:help] = "--help" if help
          options[:history_max_int] = "--history-max-int #{history_max_int}" if history_max_int
          options[:no_hooks] = "--no-hooks" if no_hooks
          options[:recreate_pods] = "--recreate-pods" if recreate_pods
          options[:timeout_duration] = "--timeout-duration #{timeout_duration}" if timeout_duration
          options[:wait] = "--wait" if wait
        end
      end
    end
  end
end
