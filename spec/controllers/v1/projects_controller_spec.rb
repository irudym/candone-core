require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do

  describe "GET #index" do
    xit "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
