require 'rails_helper'

RSpec.describe LecturesController, :type => :controller do
  describe "GET /lectures" do
    let(:lecture1) { Lecture.create(name: "Test1", body: "Nothing here!") }
    let(:lecture2) { Lecture.create(name: "Test2", body: "Nothing here!") }

    it "renders the :index templatea and expects to load the lectures in @lectures" do
      get :index
      expect(response).to render_template("index")
      expect(Lecture.count).to_not be_nil
      expect(assigns(:lectures)).to eq [lecture1, lecture2]
    end
  end

  describe "GET /lectures/new" do
    it "renders the :new tempate and returns 200(OK) status code" do
      get :new
      expect(response).to have_http_status 200
      expect(response).to render_template("new")
    end
  end

  describe "POST /lectures/create" do
    context "creates with valid params" do
      let(:valid_lecture) { { name: 'Test', body: 'Testing the create method in controller' } }

      it "it successfully creates a new lecture" do
        post :create, valid_lecture
        expect(Lecture.last.name).to eq 'Test'
        expect(Lecture.last.body).to eq 'Testing the create method in controller'
      end

      it "saves the new lecture and redirects to it with notice" do
        post :create, valid_lecture
        should redirect_to(Lecture.last)
        expect(flash[:notice]).to eq 'Lecture was successfully created.'
      end
    end

    context "creates with invalid params" do
      let(:invalid_lecture) { {name: nil, body: nil} }

      it "re-renders the :new template without saving the new lecture" do
        post :create, invalid_lecture
        should render_template("new")
        expect(response).to have_http_status 422
      end
    end
  end

  describe "DELETE /lectures/:id" do
    let(:lecture) { Lecture.create(name: 'Test', body: 'Test') }
    let(:test) { Task.create(lecture_id: lecture.id, name: 'Write tests', description: 'RSpec master') }

    it "deletes lecture from database" do
      expect { delete :destroy, id: lecture.id }.to change(Lecture, :count).by -1
    end

    it "redirects to #index with notice message" do
      delete :destroy, id: lecture.id
      should redirect_to lectures_path
      expect(flash[:notice]).to eq 'Lecture was successfully deleted.'
    end

    it "deletes related tasks" do
      expect(lecture.tasks.empty?).to be true
    end
  end

  describe "PUT /feeds/:id" do
    let(:lecture) { Lecture.create(name: 'Test1', body: 'Test1') }

    context "updates with valid params" do
      let(:lecture_name) { 'Updated' }
      let(:lecture_body) { 'Updated' }

      it "should update the lecture name and body and redirect to the updated lecture with notice" do
        put :update, id: lecture.id, name: lecture_name, body: lecture_body
        lecture.reload
        expect(lecture.name).to eq('Updated')
        expect(lecture.body).to eq('Updated')
        expect(response).to have_http_status 304
        expect(response).to redirect_to(lecture)
        expect(flash[:notice]).to eq 'Lecture was successfully updated.'
      end
    end

    context "updates with invalid params" do
      let(:lecture_name) { '' }
      let(:lecture_body) { nil }

      it "should not update the lecture name and body and re-render the :edit template" do
        put :update, id: lecture.id, name: lecture_name, body: lecture_body
        lecture.reload
        expect(lecture.name).to eq 'Test1'
        expect(lecture.body).to eq 'Test1'
        expect(response).to have_http_status 400
        expect(response).to render_template("edit")
      end
    end
  end
end