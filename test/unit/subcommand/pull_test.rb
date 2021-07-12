require "test_helper"
require "rhelm/subcommand/pull"

describe Rhelm::Subcommand::Pull do
  describe "with a subject without flags" do
    let(:subject) do
      ::Rhelm::Subcommand::Pull.new(
        "example-chart",
        ca_file: "/tmp/x509/ca",
        cert_file: "/tmp/x509/cert",
        destination: "/tmp/foo",
        devel: true,
        insecure_skip_tls_verify: true,
        key_file: "/tmp/my-key",
        keyring: "~/.gnupg/pubring.example-01.gpg",
        pass_credentials: true,
        password: "password123",
        prov: true,
        repo: "https://helm.example.net/",
        untar: true,
        untardir: "/tmp/helm",
        username: "foo",
        verify: true,
        version: "3.12.14"
      )
    end

    describe "#subject_name" do
      it "returns the string 'pull'" do
        assert_equal subject.subcommand_name, "pull"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call
        ca_file_index = command.index("--ca-file")
        cert_file_index = command.index("--cert-file")
        destination_index = command.index("--destination")
        key_file_index = command.index("--key-file")
        keyring_index = command.index("--keyring")
        password_index = command.index("--password")
        repo_index = command.index("--repo")
        untardir_index = command.index("--untardir")
        username_index = command.index("--username")
        version_index = command.index("--version")

        assert_equal command[0], "helm"
        assert_equal command[1], "pull"
        assert ca_file_index
        assert_equal command[ca_file_index + 1], "/tmp/x509/ca"
        assert cert_file_index
        assert_equal command[cert_file_index + 1], "/tmp/x509/cert"
        assert destination_index
        assert_equal command[destination_index + 1], "/tmp/foo"
        assert key_file_index
        assert_includes command, "--devel"
        assert_includes command, "--insecure-skip-tls-verify"
        assert_equal command[key_file_index + 1], "/tmp/my-key"
        assert keyring_index
        assert_equal command[keyring_index + 1], "~/.gnupg/pubring.example-01.gpg"
        assert_includes command, "--pass-credentials"
        assert password_index
        assert_equal command[password_index + 1], "password123"
        assert_includes command, "--prov"
        assert repo_index
        assert_equal command[repo_index + 1], "https://helm.example.net/"
        assert_includes command, "--untar"
        assert untardir_index
        assert_equal command[untardir_index + 1], "/tmp/helm"
        assert username_index
        assert_equal command[username_index + 1], "foo"
        assert_includes command, "--verify"
        assert version_index
        assert_equal command[version_index + 1], "3.12.14"
      end
    end
  end
end
