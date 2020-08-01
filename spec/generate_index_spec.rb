require 'rails_helper'

RSpec.describe 'generate resource', type: :system do
  describe 'index page' do
    it 'shows the name of the app' do
      visit generate_index_path
      expect(page).to have_content('Kalique')
    end
  end
end
