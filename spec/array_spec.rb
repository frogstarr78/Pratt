require 'spec_helper'
require 'pratt'

describe Array do
  it "to_sentence concatenates each element correctly with no elements" do
    [].to_sentence.should eql('')
  end

  it "to_sentence concatenates each element correctly with one element" do
    %w(a).to_sentence.should eql('a')
  end

  it "to_sentence concatenates each element correctly with two elements" do
    %w(a b).to_sentence.should eql('a and b')
  end

  it "to_sentence concatenates each element correctly with >= three elements" do
    %w(a b c d).to_sentence.should eql('a, b, c, and d')
  end

  it "to_sentence concatenates each element correctly with >= three elements and a different conjunction" do
    %w(a b c d).to_sentence('&').should eql('a, b, c, & d')
  end
end
