require "test_helper"
require "helm/subcommand/version"

describe Helm::Subcommand::Version do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Helm::Subcommand::Version.new
    end

    describe "#subcommand_name" do
      it "#subcommand_name" do
        assert_equal subject.subcommand_name, "version"
      end
    end
  end
end
