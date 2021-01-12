require "test_helper"
require "helm/subcommand/install"

describe Helm::Subcommand::Install do
  describe "with a subject without flags" do
    let(:subject) do
      ::Helm::Subcommand::Install.new("example-name", "example-chart")
    end

    describe "#subject_name" do
      it "returns the string 'install'" do
        assert_equal subject.subcommand_name, "install"
      end
    end
  end
end
