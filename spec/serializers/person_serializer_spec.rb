require 'spec_helper'

describe PersonSerializer do

  let(:person) { create(:person) }
  subject { described_class.new(person) }

  it "builds" do
    expect {
      subject.to_json
    }.to_not raise_error
  end

end
