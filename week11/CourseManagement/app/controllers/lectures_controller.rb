class LecturesController < ApplicationController
  def index
    @lectures = Lecture.all
  end

  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.new(lecture_params)

    if @lecture.save
      redirect_to @lecture, notice: 'Lecture was successfully created.'
    else
      render :new, status:422
    end
  end

  def edit
    @lecture = find_lecture
  end

  def show
    @lecture = find_lecture
  end

  def update
    @lecture = find_lecture

    if @lecture.update(lecture_params)
      redirect_to @lecture, status: 304, notice: 'Lecture was successfully updated.'
    else
      render :edit, status: 400
    end
  end

  def destroy
    @lecture = find_lecture
    @lecture.destroy

    redirect_to lectures_path, notice: 'Lecture was successfully deleted.'
  end

  private

  def lecture_params
    params.permit(:name, :body)
  end

  def find_lecture
    Lecture.find(params[:id])
  end
end