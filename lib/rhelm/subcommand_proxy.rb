require 'open3'
require 'pry-byebug'

module Rhelm
  class Client
    class SubcommandProxy
      def initialize(subcommand_name, client, *args, **kwargs)
        unless SUBCOMMANDS.include?(subcommand_name.to_sym)
          raise(Error, "Unknown subcommand #{subcommand_name}")
        end

        kwargs[:client] ||= client
        class_name = "::Rhelm::Subcommand::#{subcommand_name.to_s.capitalize}"
        @subcommand = Object.const_get(class_name).new(*args, **kwargs)
      end

      def method_missing(m, *args, **kwargs, &block)
        @subcommand.send m, *args, **kwargs, &block
      end
    end
  end
end
