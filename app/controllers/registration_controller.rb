class RegistrationController < ApplicationController
  before_action :set_regis, except: [:index]
  def index
    @regis = Registration.where(state: 1)
    @applied = false
  end

  def apply
    case @regis.course.category.downcase
    when "online"
      if @regis.count_students < 3 && @regis.state == 1
        @regis.users << current_user
        @regis.count_students += 1
        if @regis.count_students == 3
          students = 3
          course_start(students)
        end
        timer_regis()
        @regis.save
        redirect_to :back
      else 
        flash[:error] = "Sorry, It is already full"
        redirect_to :back
      end
    when "offline"
      if @regis.count_students < 8 && @regis.state == 1
        @regis.users << current_user
        @regis.count_students += 1
        if @regis.count_students == 8
          students = 8
          course_start(students)
        end
        timer_regis()
        @regis.save
        redirect_to :back
      else 
        flash[:error] = "Sorry, It is already full"
        redirect_to :back
      end
  
    else
      ##########################
    end
  end

  def cancel
    if @regis.users.ids.present?
      @regis.count_students -= 1
      @regis.users.delete(current_user)
      if @regis.state == 0
        @regis.state = 1
      end
      @regis.save
      redirect_to :back
    else
      flash[:error] = "Your command was not executed"
      redirect_to :back
    end
  end


  private
  def set_regis
    @regis = Registration.find(params[:id])
  end

  def course_start(students)
    @regis.state = 0 # 수강신청 닫힘
    course = Course.find(@regis.course_id)
    course.count_students = students
    course.save
  end

  def timer_regis
    @timer = Time.now + 1.day
    if @timer < Time.now 
      @regis.count_students -= 1
      @regis.users.delete(current_user)
      if @regis.state == 0
        @regis.state = 1
      end
      @regis.save
    end 
  end
end
