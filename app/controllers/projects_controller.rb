class ProjectsController < ApplicationController
  
  def index
    @projects = Project.all
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    params.inspect
    @project = Project.find(params[:id])
    @project.inspect
    @project.update_attributes(permited_params)
    flash[:notice] = "Project has been edited"
    redirect_to @project
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
      flash[:notice] = "Product has been created."
      redirect_to @project
    else
      flash[:alert] = "product error"
      render :action => "new"
    end
  end

  private
  def permited_params
    params.require(:project).permit(:name, :description)
  end
end
