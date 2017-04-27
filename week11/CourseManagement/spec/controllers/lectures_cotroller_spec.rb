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
      let(:valid_lecture) { {lecture: {name: 'Test', body: 'Testing the create method in controller'}} }

      it "it successfully creates a new lecture" do
        post :create, valid_lecture
        expect(assigns(:lecture).name).to eq 'Test'
        expect(assigns(:lecture).body).to eq 'Testing the create method in controller'
      end

      it "saves the lecture to database" do
        expect { post :create, valid_lecture }.to change(Lecture, :count).by 1
      end

      it "redirects to new lecture with notice" do
        post :create, valid_lecture
        expect(response).to redirect_to(Lecture.last)
        expect(flash[:notice]).to eq 'Lecture was successfully created.'
      end
    end

    context "creates with invalid params" do
      let(:invalid_lecture) { {lecture: {name: nil, body: nil}} }

      it "must not save the lecture" do
        expect { post :create, invalid_lecture }.to_not change(Lecture, :count)
      end
 
      it "re-renders the :new template" do
        post :create, invalid_lecture
        expect(response).to render_template("new")
      end
    end
  end

  describe "DELETE /lectures/:id" do
    let!(:lecture) { Lecture.create(name: 'Test', body: 'Test') }
    let!(:test) { Task.create(lecture_id: lecture.id, name: 'Write tests', description: 'RSpec master') }

    it "deletes lecture from database" do
      expect { delete :destroy, id: lecture.id }.to change(Lecture, :count).by -1
    end

    it "redirects to #index with notice message" do
      delete :destroy, id: lecture.id
      expect(response).to redirect_to lectures_path
      expect(flash[:notice]).to eq 'Lecture was successfully deleted.'
    end

    it "deletes related tasks" do
      delete :destroy, id: lecture.id
      expect(lecture.tasks.empty?).to be true
    end
  end

  describe "PUT /lectures/:id" do
    let(:lecture) { Lecture.create(name: 'Test1', body: 'Test1') }

    context "updates with valid params" do
      let(:valid_params) { {id: lecture.id, lecture: {name: 'Updated', body: 'Updated'}} }

      it "should update the lecture name and body and redirect to the updated lecture with notice" do
        put :update, valid_params
        lecture.reload
        expect(lecture.name).to eq('Updated')
        expect(lecture.body).to eq('Updated')
        expect(response).to redirect_to(lecture)
        expect(flash[:notice]).to eq 'Lecture was successfully updated.'
      end
    end

    context "updates with invalid params" do
      let(:invalid_params) { {id: lecture.id, lecture: {name: '', body: nil}} }

      it "should not update the lecture name and body and re-render the :edit template" do
        put :update, invalid_params
        lecture.reload
        expect(lecture.name).to eq 'Test1'
        expect(lecture.body).to eq 'Test1'
        expect(response).to render_template("edit")
      end
    end
  end
end