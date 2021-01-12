require "test_helper"
require "rhelm/subcommand/install"

describe Rhelm::Subcommand::Install do
  describe "with a subject without flags" do
    let(:subject) do
      ::Rhelm::Subcommand::Install.new("example-name", "example-chart")
    end

    describe "#subject_name" do
      it "returns the string 'install'" do
        assert_equal subject.subcommand_name, "install"
      end
    end
  end
end
