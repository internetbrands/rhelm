require_relative "base"

module Rhelm
  module Subcommand
    ## Helm install subcommand: `helm install [NAME] [CHART] [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_install/
    class Install < Base
      attr_reader :chart,
                  :atomic,
                  :ca_file,
                  :cert_file,
                  :create_namespace,
                  :dependency_update,
                  :description,
                  :devel,
                  :disable_openapi_validation,
                  :dry_run,
                  :generate_name,
                  :insecure_skip_tls_verify,
                  :key_file,
                  :keyring,
                  :name_template,
                  :no_hooks,
                  :output,
                  :password,
                  :post_renderer,
                  :release,
                  :render_subchart_notes,
                  :replace,
                  :repo,
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
        @create_namespace = options[:create_namespace]
        @dependency_update = options[:dependency_update]
        @description = options[:description]
        @devel = !!options[:devel]
        @disable_openapi_validation = !!options[:disable_openapi_validation]
        @dry_run = options[:dry_run]
        @generate_name = options[:generate_name]
        @insecure_skip_tls_verify = options[:insecure_skip_tls_verify]
        @key_file = options[:key_file]
        @keyring = options[:keyring]
        @name_template = options[:name_template]
        @no_hooks = options[:no_hooks]
        @output = options[:output]
        @password = options[:password]
        @post_renderer = options[:post_renderer]
        @render_subchart_notes = options[:render_subchart_notes]
        @replace = options[:replace]
        @repo = options[:repo]
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
        "install"
      end

      def cli_args
        super.tap do |args|
          args << '--atomic' if atomic
          args << ['--ca-file', ca_file] if ca_file
          args << ['--cert-file', cert_file] if cert_file
          args << '--create-namespace' if create_namespace
          args << '--dependency-update' if dependency_update
          args << ['--description', description] if description
          args << '--devel' if devel
          args << '--disable-openapi-validation' if disable_openapi_validation
          args << '--dry-run' if dry_run
          args << '--generate-name' if generate_name
          args << '--insecure-skip-tls-verify' if insecure_skip_tls_verify
          args << ['--key-file', key_file] if key_file
          args << ['--keyring', keyring] if keyring
          args << ['--name-template', name_template] if name_template
          args << '--no-hooks' if no_hooks
          args << ['--output', output] if output
          args << ['--password', password] if password
          args << ['--post-renderer', post_renderer] if post_renderer
          args << '--render-subchart-notes' if render_subchart_notes
          args << '--replace' if replace
          args << ['--repo', repo] if repo

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
          args << ['version', version] if version
          args << '--wait' if wait

          args << release
          args << chart
        end.flatten
      end
    end
  end
end
