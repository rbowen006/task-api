class TasksController < ApplicationController
  before_action :set_task, only: [:complete]

  # POST /tasks
  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_content
    end
  end

  # GET /tasks
  def index
    tasks = Task.all
    render json: tasks, status: :ok
  end

  # PATCH /tasks/:id/complete
  def complete
    if @task
      @task.update(completed_at: Time.current)
      render json: @task, status: :ok
    else
      render json: { error: "Task not found" }, status: :not_found
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = Task.find_by(id: params[:id])
  end
end