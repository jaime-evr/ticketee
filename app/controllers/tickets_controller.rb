class TicketsController < ApplicationController
  before_action :find_project

  def new
    @tickets = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(permited_params)
    if @ticket.save
      flash[:notice] = "Ticket has been created"
      redirect_to [@project]
    else
      flash[:alert] = "All fields required"
      render action: "new"
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def permited_params
    params.require(:ticket).permit(:title, :description)
  end
end
