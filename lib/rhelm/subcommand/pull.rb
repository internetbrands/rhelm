require_relative "base"

module Rhelm
  module Subcommand
    ## Helm install subcommand: `helm pull [NAME] [CHART] [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_pull/
    class Pull < Base
      attr_reader :ca_file,
                  :chart,
                  :cert_file,
                  :destination,
                  :devel,
                  :insecure_skip_tls_verify,
                  :key_file,
                  :keyring,
                  :password,
                  :prov,
                  :repo,
                  :untar,
                  :untardir,
                  :username,
                  :verify,
                  :version

      def initialize(chart, options = {})
        super(options)

        @chart = chart
        @ca_file = options[:ca_file]
        @cert_file = options[:cert_file]
        @destination = options[:destination]
        @devel = !!options[:devel]
        @insecure_skip_tls_verify = !!options[:insecure_skip_tls_verify]
        @key_file = options[:key_file]
        @keyring = options[:keyring]
        @password = options[:password]
        @repo = options[:repo]
        @untar = !!options[:untar]
        @untardir = options[:untardir]
        @username = options[:username]
        @verify = !!options[:verify]
        @version = options[:version]
      end

      def subcommand_name
        "pull"
      end

      def cli_args
        super.tap do |args|
          args << ['--ca-file', ca_file] if ca_file
          args << ['--cert-file', cert_file] if cert_file
          args << ['--destination', destination] if destination
          args << '--devel' if devel
          args << '--insecure-skip-tls-verify' if insecure_skip_tls_verify
          args << ['--key-file', key_file] if key_file
          args << ['--keyring', keyring] if keyring
          args << ['--password', password] if password
          args << ['--repo', repo] if repo
          args << '--untar' if untar
          args << ['--untardir', untardir] if untardir
          args << ['--username', username] if username
          args << '--verify' if verify
          args << ['--version', version] if version

          args << chart
        end.flatten
      end
    end
  end
end
