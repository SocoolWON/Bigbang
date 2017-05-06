class CoursesController < ApplicationController
before_action :authenticate_teacher!, except: [:index, :req_head, :classRoom]
before_action :set_course, only: [:show, :edit, :update, :destroy]
  def index
    @course = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    course_others()
    if @course.save
      create_regis()
      redirect_to '/online'
    else
      #redirect_back(fallback_location: new_course_path)
      render text: @course.errors.full_messages[0]
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      course_others()
      @course.save
      redirect_to '/online'
    else
      #redirect_back(fallback_location: new_course_path)
      render text: @course.errors.full_messages[0]
    end
  end

  def show
  end

  def destroy
    if @course.destroy
      redirect_to '/online'
    end
  end

  def classRoom
    course_ids = current_user.courses.ids  
    if course_ids.present?
      @courses = Array.new
      course_ids.each do |id|
        @courses << Course.find(id)
      end
    end
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:category, :location, :introduction, :course_type, :started_at, :german_time, :teacher_id, :days => [])
  end

  def course_others
    @course.days = @course.days.scan(/\w{3}/).to_a
    @course.ended_at = @course.started_at + 4.week
    if @course.category.downcase == "online"
        @course.course_hour = "1h"
        @course.location = nil
        @course.total_classes = 8
    else
        @course.course_hour = "2h"
        @course.total_classes = 4
    end

    if @course.german_time.to_i <= 17  #Summer time 일때는 + 8로
       korea_time = @course.german_time.to_i + 7
       if @course.german_time.include?"30"
         @course.korean_time = korea_time.to_s + ":30"
       else
         @course.korean_time = korea_time.to_s + ":00"
       end
    elsif @course.german_time.to_i > 17 # 17 이후로는 한국날짜가 + 1 된다. 독일이 일요일이면, 한국은 월요일.
       korea_time = (@course.german_time.to_i + 7) % 24
       if @course.german_time.include?"30"
         @course.korean_time = korea_time.to_s + ":30"
       else
         @course.korean_time = korea_time.to_s + ":00"
       end
    else
    end
  end

  def create_regis
    Registration.create(teacher_id: @course.teacher_id, course_id: @course.id, state: 1, count_students: 0)
  end

  def req_head
    @header = request.headers
  end
end
