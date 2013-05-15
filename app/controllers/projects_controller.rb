class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
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
    @project = Project.find(params[:id])
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
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:notice] = "Project has been deleted"
      redirect_to projects_path 
    end
  end

  private
  def permited_params
    params.require(:project).permit(:name, :description)
  end
end