require 'spec_helper'

describe "CLI" do
  describe "integration spec" do
    let(:cli) { Stefon::CLI.new }

    context "with nothing to do" do
      it "runs without errors" do
        cli.run
      end
    end
  end
end
