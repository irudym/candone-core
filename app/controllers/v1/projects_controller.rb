class V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all
  end

  # POST /projects
  def create
    # @project = Task.create_with_persons!(params[:persons], task_params)
    @project = Project.create_with_persons_tasks_notes!(project_params, params)
    render :show, status: 201
  end

  # GET /projects/:id
  def show
  end

  # PUT /projects/:id
  def update
    # @task.update_with_persons(params[:persons], task_params)
    @project.update_with_persons_tasks_notes(project_params, params)
    render :show, status: 202
  end

  # DELETE /projects/:id
  def destroy
    @project.destroy
    head :no_content
  end


  private

  def project_params
    # whitelist params
    params.permit(:title, :description, :persons, :tasks, :notes, :stage)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
