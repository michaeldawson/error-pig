require 'rails_helper'

RSpec.describe PiggyFact, type: :model do
  let(:piggy_fact) { PiggyFact.new(valid_attributes) }
  let(:valid_attributes) {
    {
      fact: 'Pigs are awesome!'
    }
  }

  describe 'Validation' do
    it 'should be valid with valid attributes' do
      expect(piggy_fact).to be_valid
    end

    it 'should not be valid without a fact' do
      valid_attributes[:fact] = nil
      expect(piggy_fact).not_to be_valid
    end
  end

  describe '.best_fact' do
    context 'when no facts have been shown' do
      before do
        piggy_fact.save!
      end

      it 'returns a random fact' do
        expect(PiggyFact.best_fact).to eq(piggy_fact)
      end

      it "updates that fact's last_used date" do
        expect { PiggyFact.best_fact }.to change { piggy_fact.reload.last_used }.from(nil)
      end
    end

    context "when some facts have been shown, but others haven't" do
      let!(:first_fact) {
        PiggyFact.create!(fact: "Humans don't like reading facts that they've already seen.", last_used: 1.week.ago)
      }

      before do
        piggy_fact.save!
      end

      it "returns the piggy fact that hasn't been shown" do
        expect(PiggyFact.best_fact).to eq(piggy_fact)
      end
    end
  end
end
