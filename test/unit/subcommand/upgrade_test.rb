require "test_helper"
require "rhelm/subcommand/upgrade"

describe Rhelm::Subcommand::Upgrade do
  describe "with a subject" do
    let(:subject) do
      ::Rhelm::Subcommand::Upgrade.new(
        "example-release",
        "example-chart",
        atomic: true,
        ca_file: "/tmp/x509/ca",
        cert_file: "/tmp/x509/cert",
        cleanup_on_fail: true,
        create_namespace: true,
        description: "Installs a chart",
        devel: true,
        disable_openapi_validation: true,
        dry_run: true,
        generate_name: true,
        history_max: 10,
        insecure_skip_tls_verify: true,
        key_file: "/tmp/my-key",
        keyring: "~/.gnupg/pubring-1.gpg",
        no_hooks: true,
        output: "json",
        pass_credentials: true,
        password: "password123",
        post_renderer: "exec",
        render_subchart_notes: true,
        repo: "https://helm.example.net/",
        skip_crds: true,
        timeout: "600s",
        username: "bar",
        verify: true,
        version: "4.9.0",
        wait: true,
        wait_for_jobs: true
      )
    end

    describe "#subject_name" do
      it "returns the string 'install'" do
        assert_equal subject.subcommand_name, "upgrade"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call
        ca_file_index = command.index("--ca-file")
        cert_file_index = command.index("--cert-file")
        description_index = command.index("--description")
        history_max_index = command.index("--history-max")
        key_file_index = command.index("--key-file")
        keyring_index = command.index("--keyring")
        output_index = command.index("--output")
        password_index = command.index("--password")
        post_renderer_index = command.index("--post-renderer")
        repo_index = command.index("--repo")
        timeout_index = command.index("--timeout")
        username_index = command.index("--username")
        version_index = command.index("--version")

        assert_equal command[0], "helm"
        assert_equal command[1], "upgrade"
        assert_equal command[-2], "example-release"
        assert_equal command[-1], "example-chart"
        assert_includes command, "--atomic"
        assert ca_file_index
        assert_equal command[ca_file_index + 1], "/tmp/x509/ca"
        assert cert_file_index
        assert_equal command[cert_file_index + 1], "/tmp/x509/cert"
        assert_includes command, "--create-namespace"
        assert description_index
        assert_equal command[description_index + 1], "Installs a chart"
        assert history_max_index
        assert_equal command[history_max_index + 1], "10"
        assert_includes command, "--devel"
        assert_includes command, "--disable-openapi-validation"
        assert_includes command, "--dry-run"
        assert_includes command, "--insecure-skip-tls-verify"
        assert key_file_index
        assert_equal command[key_file_index + 1], "/tmp/my-key"
        assert keyring_index
        assert_equal command[keyring_index + 1], "~/.gnupg/pubring-1.gpg"
        assert_includes command, "--no-hooks"
        assert output_index
        assert_equal command[output_index + 1], "json"
        assert_includes command, "--pass-credentials"
        assert password_index
        assert_equal command[password_index + 1], "password123"
        assert post_renderer_index
        assert_equal command[post_renderer_index + 1], "exec"
        assert_includes command, "--render-subchart-notes"
        assert repo_index
        assert_equal command[repo_index + 1], "https://helm.example.net/"
        assert_includes command, "--skip-crds"
        assert timeout_index
        assert_equal command[timeout_index + 1], "600s"
        assert username_index
        assert_equal command[username_index + 1], "bar"
        assert_includes command, "--verify"
        assert version_index
        assert_equal command[version_index + 1], "4.9.0"
        assert_includes command, "--wait"
        assert_includes command, "--wait-for-jobs"
      end
    end
  end
end
