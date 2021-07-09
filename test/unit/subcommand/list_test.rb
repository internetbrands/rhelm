require "test_helper"
require "rhelm/subcommand/list"

describe Rhelm::Subcommand::List do
  describe "with a subject" do
    let(:subject) do
      ::Rhelm::Subcommand::List.new(
        all: true,
        all_namespaces: true,
        date: true,
        deployed: true,
        failed: true,
        filter: "app-[a-z]+",
        max: 100,
        offset: 2,
        output: 'json',
        pending: true,
        reverse: true,
        short: true,
        superseded: true,
        time_format: "2006-01-02 15:04:05Z0700",
        uninstalled: true,
        uninstalling: true
      )
    end

    describe "#subject_name" do
      it "returns the string 'lint'" do
        assert_equal subject.subcommand_name, "ls"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call
        filter_index = command.index("--filter")
        max_index = command.index("--max")
        offset_index = command.index("--offset")
        output_index = command.index("--output")
        time_format_index = command.index("--time-format")

        assert_equal command[0], "helm"
        assert_equal command[1], "ls"
        assert_includes command, "--all"
        assert_includes command, "--all-namespaces"
        assert_includes command, "--date"
        assert_includes command, "--deployed"
        assert_includes command, "--failed"
        assert filter_index
        assert_equal command[filter_index + 1], "app-[a-z]+"
        assert max_index
        assert_equal command[max_index + 1], "100"
        assert_equal command[offset_index + 1], "2"
        assert output_index
        assert_equal command[output_index + 1], "json"
        assert_includes command, "--pending"
        assert_includes command, "--reverse"
        assert_includes command, "--short"
        assert_includes command, "--superseded"
        assert time_format_index
        assert_equal command[time_format_index + 1], "2006-01-02 15:04:05Z0700"
        assert_includes command, "--uninstalled"
        assert_includes command, "--uninstalling"
      end
    end
  end
end
