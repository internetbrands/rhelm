module Rhelm
  module Subcommand
    class Error < StandardError; end

    ## Abstract base class for Helm subcommands.
    class Base
      class OptionError < StandardError; end

      attr_reader :client,
                  :debug,
                  :kube_apiserver,
                  :kube_as_group,
                  :kube_as_user,
                  :kube_context,
                  :kube_token,
                  :kubeconfig,
                  :namespace,
                  :registry_config,
                  :repository_cache,
                  :repository_config

      def initialize(options = {})
        @client = options.delete(:client) || Client.new
        @debug = options[:debug]
        @kube_apiserver = options[:kube_apiserver]
        @kube_as_group = options[:kube_as_group]
        @kube_as_user = options[:kube_as_user]
        @kube_context = options[:kube_context]
        @kube_token = options[:kube_token]
        @kubeconfig = options[:kubeconfig]
        @namespace = options[:namespace]
        @registry_config = options[:registry_config]
        @repository_cache = options[:repository_cache]
        @repository_config = options[:repository_config]
      end

      def run(client: nil, raise_on_error: true, &block)
        b = block_given? ? block : Proc.new { |_lines, status| status }

        lines, status = Open3.capture2e(*full_cli_call)
        report_failure(lines, status.exitstatus) if raise_on_error && status.exitstatus != 0

        b.yield lines, status.exitstatus
      end

      def cli_args
        [].tap do |args|
          args << "--debug" if debug
          args << ["--kube-apiserver", kube_apiserver] if kube_apiserver
          args << ["--kube-as-group", kube_as_group ] if kube_as_group
          args << ["--kube-context", kube_context] if kube_context
          args << ["--kube-token", kube_token] if kube_token
          args << ["--kubeconfig", kubeconfig ] if kubeconfig
          args << ["--namespace", namespace] if namespace
          args << ["--registry-config", registry_config] if registry_config
          args << ["--repository-cache", repository_cache] if repository_cache
          args << ["--repository-config", repository_config] if repository_config
        end.flatten
      end

      def args
        [subcommand_name, cli_args].flatten
      end

      def full_cli_call
        [@client.program, args].flatten.map(&:to_s)
      end

      def report_failure(lines, status, and_raise: true)
        sanitized_full_cli_call = full_cli_call
        kube_token_index = sanitized_full_cli_call.find_index("--kube-token")
        sanitized_full_cli_call[kube_token_index + 1] = "[REDACTED]" if kube_token_index
        preamble = "#{sanitized_full_cli_call} failed with exit status #{status}. Output follows:"
        if @client.logger
          client.logger.error(preamble)
          client.logger.error(lines)
        else
          STDERR.puts premable
          STDERR.puts lines
        end
        raise(Error, "#{sanitized_full_cli_call} failed with exit_status #{status}") if and_raise
      end
    end
  end
end
