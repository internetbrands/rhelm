require "test_helper"
require "helm/client"

describe Helm::Client do
  describe "with a subject using helm binary already in PATH" do
    let(:subject) do
      ::Helm::Client.new
    end

    describe "#run_command" do
      it "responds to the method" do
        assert subject.respond_to?(:run_command), true
      end
    end
  end
end
