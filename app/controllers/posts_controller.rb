class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :show, :destroy]

  def index
    @show = false
    set_course()
    current_user.courses.ids.each do |ids|
      if ids ==  @@course.id
       @show = true 
      end
    end
    @posts = Post.where(course_id: @@course.id) if @show == true
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    @post.course_id = @@course.id
    if @post.save
      redirect_to board_path(@@course.id)
    else
      flash[:error] = "Failed to write"
    end
  end
  def edit
  end
  def update
    if @post.update(post_params)
      redirect_to board_path(@@course.id)
    else
      flash[:error] = "Failed to edit"
    end
  end
  def show
  end
  def destroy
    if @post.destroy
      flash[:error] = "Successfully deleted"
      redirect_to board_path(@@course.id)
    else
      flash[:error] = "Failed to delete"
    end
  end
  private
  def set_post
    @post = Post.find(params[:id])
  end
  def set_course
    @@course = Course.find(params[:id])
  end
  def post_params
    params.require(:post).permit(:title, :content, :user_id, :teacher_id)
  end
end
