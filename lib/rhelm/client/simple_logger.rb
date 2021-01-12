module Rhelm
  class Client
    class SimpleLogger
      class Error < StandardError; end
      LEVELS = { debug: 3, info: 2, warn: 1, error: 0 }
      attr_accessor :level
      def initialize(level = :info)
        raise(Error, "unknown log level #{level}") unless LEVELS.key?(level)
        @level = LEVELS[level]
      end
      LEVELS.keys.each do |l|
        define_method l do |*args|
          return unless level >= LEVELS[l]
          puts "[#{l.to_s.upcase}] #{args.compact.map(&:to_s).join(' ')}"
        end
      end
    end
  end
end
