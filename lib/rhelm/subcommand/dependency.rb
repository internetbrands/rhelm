require_relative "base"

module Rhelm
  module Subcommand
    ## Helm dependency subcommand: `helm dependency COMMAND CHART [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_dependency/
    class Dependency < Base
      attr_reader :chart,
                  :command,
                  :help,
                  :keyring,
                  :skip_refresh,
                  :verify

      COMMANDS = %w(update)

      def initialize(command, chart, options = {})
        super(options)

        @command = command.to_s
        unless COMMANDS.include?(command)
          raise(OptionError, "Invalid command #{command}. Valid values are: #{COMMANDS.join(', ')}")
        end

        @chart = chart
        @help = !!options[:help]
        @keyring = options[:keyring]
        @skip_refresh = !!options[:skip_refresh]
        @verify = !!options[:verify]
      end

      def subcommand_name
        "dependency"
      end

      def cli_args
        super.tap do |args|
          args << '--help' if help
          args << ['--keyring', keyring] if keyring
          args << '--skip-refresh' if skip_refresh
          args << '--verify' if verify

          args << command
          args << chart
        end.flatten
      end
    end
  end
end
