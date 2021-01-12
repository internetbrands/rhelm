require "net/http"
require "open3"

require_relative "subcommand/install"
require_relative "subcommand/uninstall"
require_relative "subcommand/upgrade"
require_relative "subcommand/verify"
require_relative "subcommand/version"

module Helm
  class Client
    class ClientError < StandardError; end

    SUBCOMMANDS = %i(env history install rollback status test uninstall upgrade verify version)

    attr_reader :program

    def initialize(program: "helm")
      @program = program
    end

    def run_command(subcommand_name, *ordinal_options, **flag_options)
      subcommand_name = subcommand_name.to_sym

      unless SUBCOMMANDS.include?(subcommand_name)
        raise ClientError, "Unknown subcommand."
      end

      class_name = "::Helm::Subcommand::#{subcommand_name.to_s.capitalize}"
      subcommand = Object.const_get(class_name).new(*ordinal_options, flag_options)

      Open3.popen3("#{program} #{subcommand.subcommand}") do |stdin, stdout, stderr, wait_thr|
        puts stdout.read
        stdout.close

        puts stderr.read
        stderr.close

        exit_status = wait_thr.value

        unless exit_status == 0
          raise ClientError, "Client exited with non-zero code."
        end
      end
    end
  end
end
