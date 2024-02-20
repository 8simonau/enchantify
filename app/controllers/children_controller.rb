class ChildrenController < ApplicationController
  def index
    @children = current_user.children.all
  end

  def create
    @child = Child.new(child_params)
    @child.user = current_user
    if @child.save
      flash[:success] = "Child profile created"
      redirect_to children_index_path
    else
      flash[:error] = "Something went wrong"
      render "children/index", status: :unprocessable_entity
    end
  end

  def set_child
    @child = Child.find(params[:id])
    session[:active_child] = @child
    redirect_to root_path
  end

  private

  def child_params
    params.require(:child).permit(:first_name, :birth_date, :story_duration)
  end
end
