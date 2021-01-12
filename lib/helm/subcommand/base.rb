module Helm
  module Subcommand
    ## Abstract base class for Helm subcommands.
    class Base
      class OptionError < StandardError; end

      attr_reader :debug,
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

      def cli_options
        {}.tap do |options|
          options[:debug] = "--debug" if debug
          options[:kube_apiserver] = "--kube-apiserver #{kube_apiserver}" if kube_apiserver
          options[:kube_as_group] = "--kube-as-group #{kube_as_group}" if kube_as_group
          options[:kube_context] = "--kube-context #{kube_context}" if kube_context
          options[:kube_token] = "--kube-token #{kube_token}" if kube_token
          options[:kubeconfig] = "--kubeconfig #{kubeconfig}" if kubeconfig
          options[:namespace] = "--namespace #{namespace}" if namespace
          options[:registry_config] = "--registry-config #{registry_config}" if registry_config
          options[:repository_cache] = "--repository-cache #{repository_cache}" if repository_cache
          options[:repository_config] = "--repository-config #{repository_config}" if repository_config
        end
      end

      def flags
        cli_options.map { |_k, v| v }.join(" ")
      end
    end
  end
end
