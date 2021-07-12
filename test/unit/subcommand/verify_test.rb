require "test_helper"
require "rhelm/subcommand/verify"

describe Rhelm::Subcommand::Verify do
  describe "with a subject with no flags" do
    let(:subject) do
      ::Rhelm::Subcommand::Verify.new(
        "/tmp/example-path",
        keyring: "~/.gnupg/pubring.example.gpg",
      )
    end

    describe "#subject_name" do
      it "returns the string 'verify'" do
        assert_equal subject.subcommand_name, "verify"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call
        keyring_index = command.index("--keyring")

        assert command[0], "helm"
        assert command[1], "verify"
        assert command[-1], "/tmp/example-path"
        assert keyring_index
        assert_equal command[keyring_index + 1], "~/.gnupg/pubring.example.gpg"
      end
    end
  end
end

