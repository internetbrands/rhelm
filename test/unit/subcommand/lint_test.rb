require "test_helper"
require "rhelm/subcommand/lint"

describe Rhelm::Subcommand::Lint do
  describe "with a subject" do
    let(:subject) do
      ::Rhelm::Subcommand::Lint.new("/tmp/Chart.yaml", strict: true, with_subcharts: true)
    end

    describe "#subject_name" do
      it "returns the string 'lint'" do
        assert_equal subject.subcommand_name, "lint"
      end
    end

    describe "#full_cli_call" do
      it "returns the full command array" do
        command = subject.full_cli_call

        assert_equal command.length, 5
        assert_equal command[0], "helm"
        assert_equal command[1], "lint"
        assert_equal command.last, "/tmp/Chart.yaml"
        assert_includes command, "--with-subcharts"
        assert_includes command, "--strict"
      end
    end
  end
end
