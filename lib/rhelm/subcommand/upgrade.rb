require_relative "base"

module Rhelm
  module Subcommand
    ## Helm upgrade subcommand: `helm upgrade [RELEASE] [CHART] [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_upgrade/
    class Upgrade < Base
      attr_reader :release,
                  :chart,
                  :atomic,
                  :ca_file,
                  :cert_file,
                  :cleanup_on_fail,
                  :create_namespace,
                  :description,
                  :devel,
                  :disable_openapi_validation,
                  :dry_run,
                  :force,
                  :help,
                  :history_max,
                  :insecure_skip_tls_verify,
                  :install,
                  :key_file,
                  :keyring,
                  :no_hooks,
                  :output,
                  :pass_credentials,
                  :password,
                  :post_renderer,
                  :render_subchart_notes,
                  :repo,
                  :reset_values,
                  :reuse_values,
                  :set,
                  :set_file,
                  :set_string,
                  :skip_crds,
                  :timeout,
                  :username,
                  :values,
                  :verify,
                  :version,
                  :wait,
                  :wait_for_jobs

      def initialize(release, chart, options = {})
        super(options)

        @release = release
        @chart = chart
        @atomic = !!options[:atomic]
        @ca_file = options[:ca_file]
        @cert_file = options[:cert_file]
        @cleanup_on_fail = !!options[:cleanup_on_fail]
        @create_namespace = !!options[:create_namespace]
        @description = options[:description]
        @devel = !!options[:devel]
        @disable_openapi_validation = !!options[:disable_openapi_validation]
        @dry_run = !!options[:dry_run]
        @force = !!options[:force]
        @help = !!options[:help]
        @history_max = options[:history_max]
        @insecure_skip_tls_verify = !!options[:insecure_skip_tls_verify]
        @install = !!options[:install]
        @key_file = options[:key_file]
        @keyring = options[:keyring]
        @no_hooks = !!options[:no_hooks]
        @output = options[:output]
        @pass_credentials = options[:pass_credentials]
        @password = options[:password]
        @post_renderer = options[:post_renderer]
        @render_subchart_notes = !!options[:render_subchart_notes]
        @repo = options[:repo]
        @reset_values = !!options[:reset_values]
        @reuse_values = !!options[:reuse_values]
        @set = options[:set]
        @set_file = options[:set_file]
        @set_string = options[:set_string]
        @skip_crds = !!options[:skip_crds]
        @timeout = options[:timeout]
        @username = options[:username]
        @values = options[:values]
        @verify = !!options[:verify]
        @version = options[:version]
        @wait = !!options[:wait]
        @wait_for_jobs = !!options[:wait_for_jobs]
      end

      def subcommand_name
        "upgrade"
      end

      def cli_args
        super.tap do |args|
          args << '--atomic' if atomic
          args << ['--ca-file', ca_file] if ca_file
          args << ['--cert-file', cert_file] if cert_file
          args << '--cleanup-on-fail' if cleanup_on_fail
          args << '--create-namespace' if create_namespace
          args << ['--description', description] if description
          args << '--devel' if devel
          args << '--disable-openapi-validation' if disable_openapi_validation
          args << '--dry-run' if dry_run
          args << '--force' if force
          args << '--help' if help
          args << ['--history-max', history_max] if history_max
          args << '--insecure-skip-tls-verify' if insecure_skip_tls_verify
          args << '--install' if install
          args << ['--key-file', key_file] if key_file
          args << ['--keyring', keyring] if keyring
          args << '--no-hooks' if no_hooks
          args << ['--output', output] if output
          args << '--pass-credentials' if pass_credentials
          args << ['--password', password] if password
          args << ['--post-renderer', post_renderer] if post_renderer
          args << '--render-subchart-notes' if render_subchart_notes
          args << ['--repo', repo] if repo
          args << '--reset-values' if reset_values
          args << '--reuse-values' if reuse_values

          if set && !set.empty?
            case set
            when Hash
              args << set.map { |key, value| ['--set', "#{key}=#{value}" ] }.flatten
            else
              args << ['--set', set]
            end
          end

          if set_file && !set_file.empty?
            case set_file
            when Hash
              args << set_file.map { |key, value| ['--set-file', "#{key}=#{value}" ] }.flatten
            else
              args << ['--set-file', set_file]
            end
          end

          if set_string && !set_string.empty?
            case set_string
            when Hash
              args << set_string.map { |key, value| ['--set-string', "#{key}=#{value}" ] }.flatten
            else
              args << ['--set-string', set_string]
            end
          end

          args << '--skip-crds' if skip_crds
          args << ['--timeout', timeout] if timeout
          args << ['--username', username] if username

          if values && !values.empty?
            case values
            when Array
              args << values.map { |values_file| ['--values', values_file ] }.flatten
            else
              args << ['--values', values]
            end
          end

          args << '--verify' if verify
          args << ['--version', version] if version
          args << '--wait' if wait
          args << '--wait-for-jobs' if wait_for_jobs

          args << release
          args << chart
        end.flatten
      end
    end
  end
end
