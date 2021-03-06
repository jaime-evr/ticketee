class TicketsController < ApplicationController
  before_action :find_project
  before_action :find_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @ticket = @project.tickets.build
  end

  def create
    @ticket = @project.tickets.build(permited_params)
    if @ticket.save
      flash[:notice] = "Ticket has been created"
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "All fields required"
      render action: "new"
    end
  end

  def edit
  end

  def show
  end

  def destroy
    binding.pry
    if @ticket.destroy
      flash[:notice] = "Ticket has been deleted"
      redirect_to @project
    else
      flash[:alert] = "An error has ocurred"
      render action: "show"
    end
  end

  def update
    if @ticket.update_attributes(permited_params)
      flash[:notice] = "Ticket has been updated"
      redirect_to [@project, @ticket]
    else
      flash[:alert] = "An error has ocurred while updating the ticket"
      render_ [:edit, @project, @ticket]
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
  def find_ticket
    @ticket = Ticket.find(params[:id])
  end

  def permited_params
    params.require(:ticket).permit(:title, :description)
  end
end
