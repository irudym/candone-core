class V1::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  # POST /tasks
  def create
    @task = Task.create_with_persons!(params[:persons], task_params)

    if (params[:project_id])
      params[:project_id].map do |project_id|
        project = Project.find(project_id.to_i)
        project.tasks << @task if project
      end
    end
    render :show, status: 201
  end

  # GET /tasks/:id
  def show
  end

  # PUT /tasks/:id
  def update
    @task.update_with_persons(params[:persons], task_params)
    head 202
  end


  # DELETE /tasks/:id
  def destroy
    @task.destroy
    head :no_content
  end


  private

  def task_params
    # whitelist params
    params.permit(:title, :description, :urgency, :persons, :stage)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
