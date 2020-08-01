require 'rails_helper'

RSpec.describe TextGenerator do
  describe '#generate_with_strings' do
    context 'no seed given' do
      it 'gives non-blank string' do
        expect(TextGenerator.new.generate_with_strings(nil, ['Hello world.'])).not_to be_blank
      end
    end

    context 'seed given' do
      it 'gives string with seed as prefix' do
        seed = 'testing yes yes'
        expect(TextGenerator.new.generate_with_strings(seed, ['Hello world.'])).to start_with(seed)
      end
    end
  end

  describe '#generate' do
    context 'with source text present' do
      it 'generates some text' do
        create :source_text, :with_text
        expect(TextGenerator.new.generate(nil)).not_to be_blank
      end
    end

    context 'without any source texts' do
      it 'generates nil' do
        expect(TextGenerator.new.generate(nil)).to be_nil
      end
    end
  end
end
