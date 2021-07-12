require_relative 'base'

module Rhelm
  module Subcommand
    ## Helm list subcommand: `helm list [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_list/
    class List < Base
      attr_reader :all,
                  :all_namespaces,
                  :date,
                  :deployed,
                  :failed,
                  :filter,
                  :help,
                  :max,
                  :offset,
                  :output,
                  :pending,
                  :reverse,
                  :selector,
                  :short,
                  :superseded,
                  :time_format,
                  :uninstalled,
                  :uninstalling

      def initialize(options = {})
        super(options)

        @all = options[:all]
        @all_namespaces = options[:all_namespaces]
        @date = options[:date]
        @deployed = options[:deployed]
        @failed = options[:failed]
        @filter = options[:filter]
        @help = options[:help]
        @max = options[:max]
        @offset = options[:offset]
        @output = options[:output]
        @pending = options[:pending]
        @reverse = options[:reverse]
        @selector = options[:selector]
        @short = options[:short]
        @superseded = options[:superseded]
        @time_format = options[:time_format]
        @uninstalled = options[:uninstalled]
        @uninstalling = options[:uninstalling]
      end

      def subcommand_name
        'ls'
      end

      def cli_args
        super.tap do |args|
          args << '--all' if all
          args << '--all-namespaces' if all_namespaces
          args << '--date' if date
          args << '--deployed' if deployed
          args << '--failed' if failed
          args << ['--filter', filter] if filter
          args << '--help' if help
          args << ['--max', max] if max
          args << ['--offset', offset] if offset
          args << ['--output', output] if output
          args << '--pending' if pending
          args << '--reverse' if reverse
          args << ['--selector', selector] if selector
          args << '--short' if short
          args << '--superseded' if superseded
          args << ['--time-format', time_format] if time_format
          args << '--uninstalled' if uninstalled
          args << '--uninstalling' if uninstalling
        end.flatten
      end
    end
  end
end
