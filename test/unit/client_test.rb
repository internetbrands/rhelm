require "test_helper"
require "rhelm/client"

describe Rhelm::Client do
  describe "with a subject using helm binary already in PATH" do
    let(:subject) do
      ::Rhelm::Client.new
    end

    describe "#run_command" do
      it "responds to the method" do
        assert subject.respond_to?(:run_command), true
      end
    end
  end
end
