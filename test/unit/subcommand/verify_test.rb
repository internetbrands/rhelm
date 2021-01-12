require "test_helper"
require "helm/subcommand/verify"

describe Helm::Subcommand::Verify do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Helm::Subcommand::Verify.new("/tmp/example-path")
    end

    describe "#subject_name" do
      it "returns the string 'verify'" do
        assert_equal subject.subcommand_name, "verify"
      end
    end
  end
end

