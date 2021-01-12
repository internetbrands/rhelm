require_relative "base"

module Helm
  module Subcommand
    ## Helm verify subcommand: `helm verify PATH [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_verify/
    class Verify < Base
      attr_reader :path,
                  :keyring

      def initialize(path, options = {})
        super(options)

        @path = path
        @keyring = options[:keyring]
      end

      def subcommand_name
        "verify"
      end

      def subcommand
        "verify #{path} #{flags}"
      end

      def cli_options
        super.tap do |options|
          options[:keyring] = "--keyring #{keyring}" if keyring
        end
      end
    end
  end
end
