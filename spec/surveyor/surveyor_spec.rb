# encoding: utf-8

require 'spec_helper'

describe Stefon::Surveyor::SurveyorStore do
  let(:first) { Stefon::Surveyor::SurveyorStore.new }
  let(:second) { Stefon::Surveyor::SurveyorStore.new }

  before(:each) do
    first['Van Gogh'] += 1
    second['Gerhard Richter'] += 1
  end

  it 'merges scores correctly' do
    combo = first.merge_scores(second)
    combo_same = second.merge_scores(first)
    combo.should be == combo_same
    combo.should == { 'Van Gogh' => 1, 'Gerhard Richter' => 1 }
  end

  it 'merges without mutating the receiver score' do
    expect do
      first.merge_scores(second)
    end.to_not change { first }
  end

  it 'merges without mutating the message score' do
    expect do
      first.merge_scores(second)
    end.to_not change { second }
  end
end
