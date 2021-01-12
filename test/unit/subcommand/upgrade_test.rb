require "test_helper"
require "helm/subcommand/upgrade"

describe Helm::Subcommand::Upgrade do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Helm::Subcommand::Upgrade.new("example-release", "example-chart")
    end

    describe "#subject_name" do
      it "returns the string 'install'" do
        assert_equal subject.subcommand_name, "upgrade"
      end
    end
  end
end
