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
      render :new
    end
  end

  def edit
    @lecture = Lecture.find(params[:id])
  end

  def show
    @lecture = Lecture.find(params[:id])
  end

  def update
    @lecture = Lecture.find(params[:id])

    if @lecture.update(lecture_params)
      redirect_to @lecture, notice: 'Lecture was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @lecture = Lecture.find(params[:id])
    @lecture.destroy

    redirect_to lectures_path, notice: 'Lecture was successfully deleted.'
  end

  private

  def lecture_params
    params.require(:lecture).permit(:name, :body)
  end
end