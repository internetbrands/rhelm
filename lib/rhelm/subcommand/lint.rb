require_relative 'base'

module Rhelm
  module Subcommand
    ## Helm lint subcommand: `helm lint PATH [flags]`.
    ## docs: https://helm.sh/docs/helm/helm_lint/
    class Lint < Base
      attr_reader :path,
                  :set,
                  :set_file,
                  :set_string,
                  :strict,
                  :values,
                  :with_subcharts

      def initialize(path, options = {})
        super(options)

        @path = path
        @set = options[:set]
        @set_file = options[:set_file]
        @set_string = options[:set_string]
        @strict = options[:strict]
        @values = options[:values]
        @with_subcharts = options[:with_subcharts]
      end

      def subcommand_name
        'lint'
      end

      def cli_args
        super.tap do |args|
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

          if values && !values.empty?
            case values
            when Array
              args << values.map { |values_file| ['--values', values_file ] }.flatten
            else
              args << ['--values', values]
            end
          end

          args << '--with-subcharts' if with_subcharts
          args << '--strict' if strict

          args << path
        end.flatten
      end
    end
  end
end
