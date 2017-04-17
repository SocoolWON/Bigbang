class CoursesController < ApplicationController
  def index
  end
  def new
    @course = Course.new
  end
  def create
    @course = Course.new(course_params)
  end
  def destroy
  end
  private  
  def course_params
    params.require(:course).permit(:type, :started_at, :ended_at, :days, :total_classes, :course_hour, :german_time, :korean_time)
  end
end
