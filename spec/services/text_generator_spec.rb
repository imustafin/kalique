require 'rails_helper'

RSpec.describe TextGenerator do
  describe '#generate' do
    context 'no seed given' do
      it 'gives non-blank string' do
        expect(TextGenerator.new.generate(nil)).not_to be_blank
      end
    end

    context 'seed given' do
      it 'gives string with seed as prefix' do
        seed = 'testing yes yes'
        expect(TextGenerator.new.generate(seed)).to start_with(seed)
      end
    end
  end
end
