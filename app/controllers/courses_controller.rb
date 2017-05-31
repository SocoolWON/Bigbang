require "opentok"

class CoursesController < ApplicationController
before_action :authenticate_teacher!, except: [:index, :req_head, :classroom, :chatroom]
before_action :set_course, only: [:show, :edit, :update, :destroy, :chatroom]
  def index
    @course = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    course_others()
    duplicate_check(@course)
    if @error == false 
      if @course.save
        create_regis(@course.studentNumberInCourse)
        redirect_to '/online'
      else
        #redirect_back(fallback_location: new_course_path)
        render text: @course.errors.full_messages[0]
      end
    else
      flash[:notice] = "You cannot create the class, having other class at the same time."
      redirect_to :back
    end
  end

  def edit
  end

  def update
    tmp_course = Course.new(course_params)
    duplicate_check(tmp_course)
    if @error == false 
      if @course.update(course_params)
        course_others()
        @course.save
        redirect_to '/online'
      else
        #redirect_back(fallback_location: new_course_path)
        render text: @course.errors.full_messages[0]
      end
    else
      flash[:notice] = "You cannot create the class, having other class at the same time."
      redirect_to :back
    end

  end

  def show
  end

  def destroy
    if @course.destroy
      redirect_to '/online'
    end
  end

  def classroom
    if current_user
      course_ids = current_user.courses.ids  
      if course_ids.present?
        @courses = Array.new
        course_ids.each do |id|
          @courses << Course.find(id)
        end
      end
    elsif current_teacher
      @courses = current_teacher.courses     
    else
    end
  end
  
  def chatroom 
    @api_key = '45843842'
    api_secret = 'af9d7977a426e7f59ef318528b049f8a9ae518ab'

    if @course.room_session.nil?
      opentok = OpenTok::OpenTok.new @api_key, api_secret
      session = opentok.create_session :archive_mode => :always, :media_mode => :routed
      session_id = session.session_id
      @course.room_session = session
      @course.room_session_id = session_id
      @course.save
    else
      opentok = OpenTok::OpenTok.new @api_key, api_secret
      session = @course.room_session
      session_id = @course.room_session_id
    end

    @token = opentok.generate_token session_id 
    @session_id = session_id
  end

  private
  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:category, :location, :introduction, :course_type, :started_at, :german_time, :teacher_id, :studentNumberInCourse,:days => [])
  end

  def course_others
    @course.state = 1
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

  def create_regis(student)
    Registration.create(teacher_id: @course.teacher_id, course_id: @course.id, state: "open", studentNumberInCourse: student)
  end

  def req_head
    @header = request.headers
  end

  def duplicate_check(course_param)
    tmp_courses = Course.where(teacher_id: current_teacher.id, state: 1)
    if tmp_courses.present?
      tmp_courses.each do |course|
        tmp_array = course.days.scan(/\w{3}/).to_a
        if course_param.days.include?tmp_array[0] or course_param.days.include?tmp_array[1]
          if course_param.german_time.to_time.hour == course.german_time.to_time.hour
            @error = true
            break
          elsif course_param.german_time.to_time.hour + 1 == course.german_time.to_time.hour
            if course_param.german_time.include?"30"
              @error = true
              break
            else
              @error = false 
            end
          elsif course.german_time.to_time.hour + 1 == course_param.german_time.to_time.hour
            if course.german_time.include?"30"
              @error = true
              break
            else
              @error = false
            end
          else 
            @error = false
          end
        else
          @error = false
        end
      end
    else
      @error = false
    end
  end
end
