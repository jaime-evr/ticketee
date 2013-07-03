class ProjectsController < ApplicationController
  
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  
  def index
    @projects = Project.all
  end

  def edit
  end

  def update
    if @project.update_attributes(permited_params)
      flash[:notice] = "Project has been updated"
      redirect_to @project
    else
      flash[:alert] = "All fields required"
      redirect_to action: "edit"
    end
  end

  def new
    @project = Project.new
  end

  def show
  end

  def create
    @project = Project.new(permited_params)
    if @project.save
      flash[:notice] = "Project has been created."
      redirect_to @project
    else
      flash[:alert] = "All fields required"
      render action: "new"
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = "Project has been deleted"
      redirect_to projects_path 
    end
  end

  private
  def find_project
    @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "the project you were looking for culd not be found"
  end

  def permited_params
    params.require(:project).permit(:name, :description)
  end
end