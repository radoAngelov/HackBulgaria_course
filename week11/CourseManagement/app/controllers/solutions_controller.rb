class SolutionsController < ApplicationController
  def index
    @solutions = Solution.for_task(params[:task_id])
  end

  def create
    @lecture = Lecture.find(params[:lecture_id])
    @lecture.tasks.find(params[:task_id]).solutions.create!(solution_params)

    redirect_to lecture_task_solutions_path(params[:lecture_id], params[:task_id]), notice: "Solution was successfully created."
  end

  def new
    @solution = Solution.new
  end

  def edit
    @solution = Solution.for_task(params[:task_id]).find(params[:id])
  end

  def show
    @solution = Solution.for_task(params[:task_id]).find(params[:id])
  end

  def update
    @lecture = Lecture.find(params[:lecture_id])
    @solution = Solution.for_task(params[:task_id]).find(params[:id])

    if @solution.update(solution_params)
      redirect_to lecture_task_solutions_path(params[:lecture_id], params[:task_id]), notice: 'Solution was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @solution = Solution.for_task(params[:task_id]).find(params[:id])
    @solution.destroy

    redirect_to lecture_task_solutions_path(params[:lecture_id], params[:task_id]), notice: 'Solution was successfully deleted.'
  end

  private

  def solution_params
    params.require(:solution).permit(:answer, :task_id)
  end
end