require "test_helper"
require "helm/subcommand/uninstall"

describe Helm::Subcommand::Uninstall do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Helm::Subcommand::Uninstall.new("example-release")
    end

    describe "#subject_name" do
      it "returns the string 'uninstall'" do
        assert_equal subject.subcommand_name, "uninstall"
      end
    end
  end
end
