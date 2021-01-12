require_relative "base"

module Rhelm
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

      def cli_args
        super.tap do |args|
          args << ['--keyring', keyring] if keyring

          args << path
        end.flatten
      end
    end
  end
end
