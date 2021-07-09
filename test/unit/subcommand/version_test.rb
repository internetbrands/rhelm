require "test_helper"
require "rhelm/subcommand/version"

describe Rhelm::Subcommand::Version do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Rhelm::Subcommand::Version.new(
        short: true,
        template: "my-template-.GoVersion-foo"
      )
    end

    describe "#subcommand_name" do
      it "#subcommand_name" do
        assert_equal subject.subcommand_name, "version"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call
        template_index = command.index("--template")

        assert_equal command[0], "helm"
        assert_equal command[1], "version"
        assert_includes command, "--short"
        assert_equal command[template_index + 1], "my-template-.GoVersion-foo"
      end
    end
  end
end
