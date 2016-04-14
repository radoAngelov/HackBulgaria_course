class TasksController < ApplicationController
  def index
    @tasks = Task.for_lecture(params[:lecture_id])
  end

  def create
    @task = Lecture.find(params[:lecture_id]).tasks.create!(task_params)

    redirect_to lecture_tasks_path(params[:lecture_id]), notice: 'Task was successfully created.'
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.for_lecture(params[:lecture_id]).find(params[:id])
  end

  def show
    @task = Task.for_lecture(params[:lecture_id]).find(params[:id])
  end

  def update
    @task = Task.for_lecture(params[:lecture_id]).find(params[:id])

    if @task.update(task_params)
      redirect_to lecture_tasks_path(params[:lecture_id]), notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task = Task.for_lecture(params[:lecture_id]).find(params[:id])
    @task.destroy

    redirect_to lecture_tasks_path(params[:lecture_id]), notice: 'Task was successfully deleted.'
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :lecture_id)
  end
end