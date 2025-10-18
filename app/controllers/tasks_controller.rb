class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_routine
  before_action :set_task, only: [ :edit, :update, :destroy ]

  # POST /routines/:routine_id/tasks
  def create
    @task = @routine.tasks.build(task_params)
    if @task.save
      redirect_to routine_path(@routine), notice: "タスクを追加しました"
    else
      render "routines/show", status: :unprocessable_entity
    end
  end

  # GET /routines/:routine_id/tasks/:id/edit
  def edit
  end

  # PATCH/PUT /routines/:routine_id/tasks/:id
  def update
    if @task.update(task_params)
      redirect_to routine_path(@routine), notice: "タスクを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /routines/:routine_id/tasks/:id
  def destroy
    @task.destroy
    redirect_to routine_path(@routine), notice: "タスクを削除しました"
  end

  private

  def set_routine
    @routine = current_user.routines.find(params[:routine_id])
  end

  def set_task
    @task = @routine.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :estimated_min)
  end
end
