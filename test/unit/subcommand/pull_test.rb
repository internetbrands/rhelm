require "test_helper"
require "rhelm/subcommand/install"

describe Rhelm::Subcommand::Pull do
  describe "with a subject without flags" do
    let(:subject) do
      ::Rhelm::Subcommand::Pull.new("example-chart")
    end

    describe "#subject_name" do
      it "returns the string 'pull'" do
        assert_equal subject.subcommand_name, "pull"
      end
    end
  end
end
