class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]



  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = User.first.tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @task = User.first.tasks.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "「#{task.name}」を編集しました。"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}を削除しました」"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :user_id)
  end

  def set_task
    @task = @current_user.tasks.find(params[:id])
  end

end