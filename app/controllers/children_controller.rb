class ChildrenController < ApplicationController
  def index
    @children = current_user.children.all
    @new_child = Child.new
    @background = "forest_children"
    @title = "Mes enfants"
  end

  def new
    @child = Child.new
    @title = "Créer un profil"
    @background = "child-creation"
  end

  def create
    @child = Child.new(child_params)
    @child.user = current_user
    unless @child.avatar.attached?
      @child.avatar.attach(io: File.open("app/assets/images/avatar.jpg"), filename: "avatar.jpg", content_type: "image/jpg")
    end
    if @child.save
      flash[:success] = "Child profile created"
      redirect_to children_path
    else
      flash[:error] = "Something went wrong"
      render "children/index", status: :unprocessable_entity
    end
  end

  def set_child
    @child = Child.find(params[:id])
    current_user.active_child = @child
    current_user.save
    redirect_to root_path
  end

  private

  def child_params
    params.require(:child).permit(:first_name, :birth_date, :story_duration, :avatar)
  end
end
