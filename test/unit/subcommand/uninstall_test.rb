require "test_helper"
require "rhelm/subcommand/uninstall"

describe Rhelm::Subcommand::Uninstall do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Rhelm::Subcommand::Uninstall.new("example-release")
    end

    describe "#subject_name" do
      it "returns the string 'uninstall'" do
        assert_equal subject.subcommand_name, "uninstall"
      end
    end
  end
end
