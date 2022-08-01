require "test_helper"
require "rhelm/subcommand/status"

describe Rhelm::Subcommand::Status do
  describe "with a subject" do
    let(:subject) do
      ::Rhelm::Subcommand::Status.new(
        "example-release",
        output: 'json',
        revision: 2,
        show_desc: true
      )
    end

    describe "#subject_name" do
      it "returns the string 'status'" do
        assert_equal subject.subcommand_name, "status"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call
        output_index = command.index("--output")
        revision_index = command.index("--revision")

        assert_equal command[0], "helm"
        assert_equal command[1], "status"
        assert output_index
        assert_equal command[output_index + 1], "json"
        assert revision_index
        assert_equal command[revision_index + 1], "2"
        assert_includes command, "--show-desc"
      end
    end
  end
end
