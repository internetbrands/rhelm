require "test_helper"
require "rhelm/subcommand/uninstall"

describe Rhelm::Subcommand::Uninstall do
  describe "with a subject with a single release" do
    let(:subject) do
      ::Rhelm::Subcommand::Uninstall.new(
        "example-release",
        description: "Hello World",
        dry_run: false,
        no_hooks: true,
        keep_history: true,
        timeout: "30s"
      )
    end

    describe "#subject_name" do
      it "returns the string 'uninstall'" do
        assert_equal subject.subcommand_name, "uninstall"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call

        assert_equal command[0], "helm"
        assert_equal command[1], "uninstall"
        assert_equal command.last, "example-release"
      end
    end
  end

  describe "with a subject with multiple releases" do
    let(:subject) do
      ::Rhelm::Subcommand::Uninstall.new(
        ["example-release-1", "example-release-2"],
        description: "Hello World!!1",
        dry_run: true,
        no_hooks: false,
        keep_history: false,
        timeout: "45s"
      )
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call
        description_index = command.index("--description")
        timeout_index = command.index("--timeout")

        assert_equal command[0], "helm"
        assert_equal command[1], "uninstall"
        assert_equal command[-2], "example-release-1"
        assert_equal command[-1], "example-release-2"
        assert_includes command, "--dry-run"
        assert description_index
        assert_equal command[description_index + 1], "Hello World!!1"
        assert_equal command[timeout_index + 1], "45s"
      end
    end
  end
end
