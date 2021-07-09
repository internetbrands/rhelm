require 'rhelm/client/simple_logger'
require 'rhelm/subcommand_proxy'

module Rhelm
  class Client
    class Error < StandardError; end

    SUBCOMMANDS = %i(
      dependency env history install lint list pull rollback
      status test uninstall upgrade verify version
    )
    SUBCOMMANDS.each { |s| require_relative "subcommand/#{s}" }

    attr_reader :program, :logger

    def initialize(program: "helm", logger: nil, **default_options)
      @program = program
      @logger ||= SimpleLogger.new
      @default_options = default_options || {}
    end

    SUBCOMMANDS.each do |subcommand|
      define_method subcommand do |*args, **kwargs, &block|
        SubcommandProxy.new(subcommand, self, *args, **@default_options.merge(kwargs), &block)
      end
    end

    def run_command(subcommand_name, *ordinal_options, **flag_options, &block)
      SubcommandProxy.new(subcommand_name, self, *ordinal_options, **@default_options.merge(flag_options), &block).run
    end

    def helm_version
      version_info[:Version]
    end

    def helm_commit
      version_info[:GitCommit]
    end

    def helm_go_version
      version_info[:GoVersion]
    end

    private

    # version.BuildInfo{Version:"v3.4.2", GitCommit:"23dd3af5e19a02d4f4baa5b2f242645a1a3af629", GitTreeState:"dirty", GoVersion:"go1.15.5"}
    HELM_VERSION_RE = /version\.BuildInfo\{Version:"([^"]+)", GitCommit:"([^"]+)", GitTreeState:"([^"]+)", GoVersion:"([^"]+)"\}/m.freeze
    def version_info
      @version_info ||= 
        version.run do |lines, status|
          if m = HELM_VERSION_RE.match(lines)
            { Version: m[1], GitCommit: m[2], GoVersion: m[4] }
          end
        end
    end
  end
end
