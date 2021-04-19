# frozen_string_literal: true

require "rails_helper"

RSpec.describe "SignedOuts", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/signed_out"
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
    end
  end
end
