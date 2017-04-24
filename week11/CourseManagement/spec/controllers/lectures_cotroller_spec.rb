require 'rails_helper'

RSpec.describe LecturesController, :type => :controller do
	describe "GET /lectures" do
		it "should render the :index template with 200(OK) status code" do
			get :index
			expect(response).to render_template("index")
			expect(response).to have_http_status 200
		end

		it "should list all lectures" do
			Lecture.create(name: "Test1", body: "Nothing here!")
			Lecture.create(name: "Test2", body: "Nothing here!")
			get :index
			expect(assigns(:lectures).size).to eq 2	
		end

		it "loads exactly all lectures in @lectures" do
			lecture1 = Lecture.create(name: "Test1", body: "Nothing here!")
			lecture2 = Lecture.create(name: "Test1", body: "Nothing here!")
			get :index
			expect(assigns(:lectures)).to match_array([lecture1, lecture2])
		end
	end

	describe "POST /lectures/new" do
		#context "with invalid attributes" do
		#	let(:invalid_lecture) {:invalid_lecture, :name => nil, :body => nil }
		#	
		#	it "re-renders the :new template" do
		#		expect(post :create, invalid_lecture).to render_template("new")
		#	end
		#
		#	it "does not save the new lecture" do
		#		expect(post :create, invalid_lecture).to_not change(Lecture,:count)
		#	end
		#end

		context "with valid attributes" do
			let(:valid_lecture) { Lecture.create(name: 'Test', body: 'Testing the create method in controller') }

			it "creates new lecture and saves it" do
				expect(post :create, valid_lecture).to change(Lecture,:count).by 1
			end
		end
	end
end