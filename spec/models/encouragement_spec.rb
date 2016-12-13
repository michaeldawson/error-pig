require 'rails_helper'

RSpec.describe Encouragement do
  describe '.positive' do
    it 'is a non-empty string' do
      encouragement = Encouragement.positive
      expect(encouragement).to be_a(String)
      expect(encouragement).not_to be_blank
    end
  end

  describe '.negative' do
    it 'is a non-empty string' do
      encouragement = Encouragement.negative
      expect(encouragement).to be_a(String)
      expect(encouragement).not_to be_blank
    end
  end
end
