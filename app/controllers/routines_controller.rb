class RoutinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_routine, only: [ :show, :edit, :update, :destroy ]

  def index
    @routines = current_user.routines
  end

  def show
    @task = @routine.tasks.build
  end

  def new
    @routine = current_user.routines.build
  end

  def create
    @routine = current_user.routines.build(routine_params)
    if @routine.save
      redirect_to routines_path, notice: "ルーティンを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 編集フォーム表示（画面遷移あり）
  end

  def update
    if @routine.update(routine_params)
      redirect_to @routine, notice: "ルーティンを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @routine.destroy
    redirect_to routines_path, notice: "ルーティンを削除しました"
  end

  private

  def set_routine
    @routine = current_user.routines.find(params[:id])
  end

  def routine_params
    params.require(:routine).permit(:name, :description)
  end
end
