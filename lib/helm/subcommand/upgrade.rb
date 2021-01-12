require_relative "base"

module Helm
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
                  :dependency_update,
                  :description,
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
                  :wait


      def initialize(release, chart, options = {})
        super(options)

        @release = release
        @chart = chart
        @atomic = options[:atomic]
        @ca_file = options[:ca_file]
        @cert_file = options[:cert_file]
        @cleanup_on_fail = options[:cleanup_on_fail]
        @create_namespace = options[:create_namespace]
        @description = options[:description]
        #options[:devel]
        #options[:disable_openapi_validation]
        @dry_run = options[:dry_run]
        @force = options[:force]
        @help = options[:help]
        @history_max = options[:history_max]
        @insecure_skip_tls_verify = options[:insecure_skip_tls_verify]
        @install = options[:install]
        @key_file = options[:key_file]
        @keyring = options[:keyring]
        @no_hooks = options[:no_hooks]
        @output = options[:output]
        @password = options[:password]
        @post_renderer = options[:post_renderer]
        @render_subchart_notes = options[:render_subchart_notes]
        @repo = options[:repo]
        @reset_values = options[:reset_values]
        @reuse_values = options[:reuse_values]
        @set = options[:set]
        @set_file = options[:set_file]
        @set_string = options[:set_string]
        @skip_crds = options[:skip_crds]
        @timeout = options[:timeout]
        @username = options[:username]
        @values = options[:values]
        @verify = options[:verify]
        @version = options[:version]
        @wait = options[:wait]
      end

      def subcommand_name
        "upgrade"
      end

      def subcommand
        "upgrade #{release} #{chart} #{flags}"
      end

      def cli_options
        super.tap do |options|
          # options[:context] = "--context #{context}" if context
          options[:atomic] = "--atomic" if atomic
          options[:ca_file] = "--ca-file #{ca_file}" if ca_file
          options[:cert_file] = "--cert-file #{cert_file}" if cert_file
          options[:cleanup_on_fail] = "--cleanup-on-fail" if cleanup_on_fail
          options[:create_namespace] = "--create-namespace" if create_namespace
          options[:dependency_update] = "--dependency-update" if dependency_update
          options[:dependency_update] = "--dependency-update" if dependency_update
          options[:description] = "--description #{description}" if description
          # options[:devel] = "--devel" if devel
          # options[:disable_openapi_validation] = "--disable_openapi_validation" if disable_openapi_validation
          options[:dry_run] = "--dry-run" if dry_run
          options[:force] = "--force" if force
          options[:help] = "--help" if help
          options[:history_max] = "--history-max #{history_max}" if history_max
          options[:insecure_skip_tls_verify] = "--insecure-skip-tls-verify" if insecure_skip_tls_verify
          options[:install] = "--install" if install
          options[:key_file] = "--key-file #{key_file}" if key_file
          options[:keyring] = "--keyring #{keyring}" if keyring
          options[:no_hooks] = "--no-hooks" if no_hooks
          options[:output] = "--output #{output}" if output
          options[:password] = "--password #{password}" if password
          options[:post_renderer] = "--post-renderer #{post_renderer}" if post_renderer
          options[:render_subchart_notes] = "--render-subchart-notes" if render_subchart_notes
          options[:repo] = "--repo #{repo}" if repo
          options[:reset_values] = "--reset-values" if reset_values
          options[:reuse_values] = "--reuse-values" if reuse_values
          if set && !set.empty?
            options[:set] = if set.respond_to?(:split)
                              set
                            else
                              set.map { |key, value| "--set #{key}=#{value}" }.join(" ")
                            end
          end
          if set_file && !set_file.empty?
            options[:set_file] = if set.respond_to?(:split)
                                   set
                                 else
                                   set_file.map { |path| "--set-file #{path}" }.join(" ")
                                 end
          end
          if set_string && !set_string.empty?
            options[:set_string] = if set.respond_to?(:split)
                                     set
                                   else
                                     set_string.map { |key, value| "--set-string #{key}=#{value}" }.join(" ")
                                   end
          end

          options[:skip_crds] = "--skip-crds" if skip_crds
          options[:timeout] = "--timeout #{timeout}" if timeout
          options[:username] = "--username #{username}" if username
          if values && !values.empty?
            options[:values] = if values.respond_to?(:split)
                                 values
                               else
                                 values.map { |val| "--values #{val}" }.join(" ")
                               end
          end
          options[:verify] = "--verify" if verify
          options[:version] = "--version #{version}" if version
          options[:wait] = "--wait" if wait
        end
      end
    end
  end
end
