class RegistrationController < ApplicationController
  before_action :set_regis, except: [:index ,:privateTutoring, :publicTutoring, :search]
  before_action :timer_check


  def privateTutoring
   @regis_all = Registration.where(studentNumberInCourse: "1", state: "open")
  end
  
  def publicTutoring
   @regis_all = Registration.where(studentNumberInCourse: "several", state: "open")
  end

  def apply
    @tmp_apply = true
    if current_user.courses.present?
      current_user.courses.each do |course|
        if course.german_time.to_time.hour == @regis.course.german_time.to_time.hour
          @tmp_apply = false
          break
        elsif @regis.course.german_time.to_time.hour + 1 == course.german_time.to_time.hour   
          @tmp_apply = false
          break
        elsif course.german_time.to_time.hour + 1 == @regis.course.german_time.to_time.hour
          @tmp_apply = false
          break
        else
          @tmp_apply = true
          break
        end
      end
    end
    
    if @tmp_apply == true 
      if @regis.present?
        @regis.user_id = current_user.id
        @regis.fee_deadline = Time.now + 24.hour 
        @regis.save
        redirect_to :back
      else
        flash[:alert] = "Error to apply"
        redirect_to :back
      end
    else
      flash[:alert] = "You cannot apply a course while your other class running"
      redirect_to :back
    end
  end

  def cancel
    @regis.user_id = nil
    if @regis.save
      redirect_to :back
    else
      flash[:alert] = "Error to cancel"
    end
  end

  def search
   @regis_all = Array.new
   courses = Course.where(course_type: params[:course_type], german_time: params[:german_time])
   if courses.present?
     courses.each do |course|
        if course.registrations.present?
          @regis_all << course.registrations
        end
     end
   end
  end
  private
  def set_regis
    @regis = Registration.find(params[:id])
  end

  def timer_check
    all_regis = Registration.where(state: "open")
    all_regis.each do |each_regis|
      if each_regis.fee_deadline.present? &&  each_regis.fee_deadline < Time.now 
        each_regis.user_id = nil
        each_regis.save
      end
    end
  end
end
