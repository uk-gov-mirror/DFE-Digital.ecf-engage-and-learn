# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Core Induction Programme Module", type: :request do
  let(:course_module) { FactoryBot.create(:course_module) }
  let(:course_module_url) { "/years/#{course_module.course_year.id}/modules/#{course_module.id}" }

  describe "when an admin user is logged in" do
    before do
      admin_user = create(:user, :admin)
      sign_in admin_user
    end

    describe "GET /create-module" do
      it "renders the create-module page" do
        get "/core-induction-programmes/#{course_module.course_year[:id]}/create-module"
        expect(response).to render_template(:new)
      end
    end

    describe "POST /create-module" do
      it "creates a new module and redirects" do
        expect(create_course_module).to redirect_to("/core-induction-programmes")
      end

      it "creates a new module that is then displayed in the list of course module" do
        create_course_module
        get cip_url(course_module.course_year.core_induction_programme[:id], course_module[:id])
        expect(response.body).to include("Additional module title")
        expect(response.body).to include("Additional module content")
      end
    end

    describe "GET /years/:years_id/modules/module_id" do
      it "renders the cip module page" do
        get course_module_url
        expect(response).to render_template(:show)
      end
    end

    describe "GET /years/:years_id/modules/module_id/edit" do
      it "renders the cip module edit page" do
        get "#{course_module_url}/edit"
        expect(response).to render_template(:edit)
      end
    end

    describe "PUT /years/:years_id/modules/module_id" do
      it "renders a preview of changes to module" do
        put course_module_url, params: { commit: "See preview", course_module: { content: "Extra content" } }
        expect(response).to render_template(:edit)
        expect(response.body).to include("Extra content")
        course_module.reload
        expect(course_module.content).not_to include("Extra content")
      end

      it "redirects to the module page when saving content" do
        put course_module_url, params: { commit: "Save changes", course_module: { content: "Adding new content" } }
        expect(response).to redirect_to(course_module_url)
        get course_module_url
        expect(response.body).to include("Adding new content")
      end

      it "redirects to the module page when saving title" do
        put course_module_url, params: { commit: "Save changes", course_module: { title: "New title" } }
        expect(response).to redirect_to(course_module_url)
        get course_module_url
        expect(response.body).to include("New title")
      end
    end
  end

  describe "when a non-admin user is logged in" do
    before do
      user = create(:user)
      sign_in user
    end

    describe "GET /years/:years_id/modules/module_id" do
      it "renders the cip module page" do
        get course_module_url
        expect(response).to render_template(:show)
      end
    end

    describe "GET /years/:years_id/modules/module_id/edit" do
      it "raises an authorization error" do
        expect { get "#{course_module_url}/edit" }.to raise_error Pundit::NotAuthorizedError
      end
    end

    describe "GET /create-module" do
      it "raises an authorization error" do
        expect { get "/core-induction-programmes/#{course_module.course_year[:id]}/create-module" }.to raise_error Pundit::NotAuthorizedError
      end
    end

    describe "POST /create-module" do
      it "raises an authorization error" do
        expect { create_course_module }.to raise_error Pundit::NotAuthorizedError
      end
    end
  end

  describe "when a non-user is accessing the module page" do
    describe "GET /years/:years_id/modules/module_id/" do
      it "renders the cip module page" do
        get course_module_url
        expect(response).to render_template(:show)
      end
    end

    describe "GET /years/:years_id/modules/module_id/edit" do
      it "redirects to the sign in page" do
        get "#{course_module_url}/edit"
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    describe "PUT /years/:years_id/modules/module_id" do
      it "redirects to the sign in page" do
        put course_module_url, params: { commit: "Save changes", course_module: { content: course_module.content } }
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    describe "GET /create-module" do
      it "redirects to the sign in page" do
        get "/core-induction-programmes/#{course_module.course_year[:id]}/create-module"
        expect(response).to redirect_to("/users/sign_in")
      end
    end

    describe "POST /create-module" do
      it "redirects to the sign in page" do
        create_course_module
        expect(response).to redirect_to("/users/sign_in")
      end
    end
  end
end

def create_course_module
  post "/core-induction-programmes/#{course_module.course_year[:id]}/create-module", params: { course_module: {
    course_year: course_module.course_year[:id],
    title: "Additional module title",
    content: "Additional module content",
    term: "spring",
  } }
end
