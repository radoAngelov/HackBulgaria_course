require 'rails_helper'

RSpec.describe LecturesController, :type => :controller do
	describe "GET /lectures" do
		let(:lecture1) { Lecture.create(name: "Test1", body: "Nothing here!") }
		let(:lecture2) { Lecture.create(name: "Test2", body: "Nothing here!") }
		
		before do
			get :index
		end

		it "renders the :index template" do
			expect(response).to render_template("index")
		end

		it "should list all lectures" do
			expect(assigns(:lecture).size).to eq 2
		end

		it "loads exactly all lectures in @lectures" do
			expect(assigns(:lectures)).to match_array([lecture1, lecture2])
		end
	end

	describe "GET /lectures/new" do
		it "renders the :new tempate" do
			get :new
			expect(response).to render_template("new")
		end
		
		it "returns status code 200(OK)" do
			get :new
			expect(response).to have_http_status 200
		end
	end

	describe "POST /lectures/new" do
		context "creates with valid params" do
      let(:valid_lecture) { { name: 'Test', body: 'Testing the create method in controller' } }

      before do
      	post :create, valid_lecture
      end

			it "saves the new lecture" do
				expect(response).to have_http_status 201
			end

      it "shows new lecture" do
        should redirect_to(Lecture.last)
      end

      it "expects notice message" do
        expect(flash[:notice]).to_not be_nil
      end
    end

		context "creates with invalid params" do
  	  let(:invalid_lecture) { {name: nil, body: nil} }

  	  before do
  	  	post :create, invalid_lecture
  	  end

			it "re-renders the :new template" do
				should render_template("new")
			end
		
			it "must not save the new lecture" do
				expect(response).to have_http_status 422
			end
		end
	end

	describe "DELETE /lectures/:id" do
		let(:lecture) { Lecture.create(name: 'Test', body: 'Test') }
		let(:test) { Task.create(lecture_id: lecture.id, name: 'Write tests', description: 'RSpec master') }

		before do
			delete :destroy, id: lecture.id
		end

		it "deletes lecture from database" do
			expect(response).to have_http_status 200
		end

		it "expects notice message" do
			expect(flash[:notice]).to_not be_nil
		end

		it "redirects to #index" do
			should redirect_to lectures_path
		end

		it "deletes related tasks" do
			expect(lecture.tasks.empty?).to be true
		end
	end

	describe "PUT /feeds/:id" do

		context "updates with valid params" do
			let(:lecture) { Lecture.create(name: 'Test1', body: 'Test1') }
			let(:lecture_name) { 'Updated' }
			let(:lecture_body) { 'Updated' }

			before do
				put :update, id: lecture.id, name: lecture_name, body: lecture_body
				lecture.reload
			end

			it "updates the lecture name" do
				expect(lecture.name).to eq('Updated')
			end

			it "updates the lecture body" do
				expect(lecture.body).to eq('Updated')
			end
		end

		context "updates with invalid params" do
			let(:invalid_update) { { lecture: { name: nil, body: nil } } }


		end
	end
end