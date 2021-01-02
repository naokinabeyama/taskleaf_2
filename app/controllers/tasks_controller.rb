class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
  	@tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
  	@task = current_user.tasks.find(params[:id])
  end

  def new
  	@task = Task.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def create
  	@task = Task.new(task_params.merge(user_id: current_user.id))
  	if @task.save
      logger.debug "task: #{@task.attributes.inspect}"
  	  redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end

  def task_logger
    @task_logger ||= Logger.new('log/task.log', 'daly')
  end

  task_logger.debug 'taskのログを出力'

  private

  def task_params
  	params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
