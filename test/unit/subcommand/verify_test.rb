require "test_helper"
require "rhelm/subcommand/verify"

describe Rhelm::Subcommand::Verify do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Rhelm::Subcommand::Verify.new("/tmp/example-path")
    end

    describe "#subject_name" do
      it "returns the string 'verify'" do
        assert_equal subject.subcommand_name, "verify"
      end
    end
  end
end

