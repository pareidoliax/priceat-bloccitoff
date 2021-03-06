class TasksController < ApplicationController
  
  def show
    @list = List.find(params[:list_id])
    @task = Task.find(params[:id])
  end

  def new
    @list = List.find(params[:list_id])
    @task = Task.new
  end

  def create
    @list = List.find(params[:list_id])
    @new_task = current_user.tasks.build(task_params)
    @new_task.list = @list
    
    if @new_task.save
      flash[:notice] = "New Task."
      redirect_to [@list, @tasks]
    else
      flash[:error] = "Nothing saved. Try again."
      render :edit
    end
  end


  def edit
    @list = List.find(params[:list_id])
    @task = Task.find(params[:id])
  end

  def update
     @list = List.find(params[:list_id])
     @task = Task.find(params[:id])
    
    if @task.update_attributes(task_params)
      flash[:notice] = "Task updated. Get back to work!"
      redirect_to [@list]
    else
      flash[:error] = "No can do, partner. Try again."
      render :edit
    end
  end


  private

    def task_params
      params.require(:task).permit(:title, :body, :status)
    end
end