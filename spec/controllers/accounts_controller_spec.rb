require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:account) { user.account }

  describe 'GET #show' do
    before do
      sign_in user
    end

    it 'renders the show template' do
      get :show, params: { id: account.id }
      expect(response).to render_template('show')
      expect(response.status).to eq(200)
    end
  end
end