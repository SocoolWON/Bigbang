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
    unless current_user.registrations.present? 
      if @regis.present?
        @regis.user_id = current_user.id
        @regis.fee_deadline = Time.now + 3.days 
        @regis.save
        redirect_to :back
      else
        flash[:alert] = "Error to apply"
        redirect_to :back
      end
    else
      flash[:alert] = "무료 수강신청은 1회만 가능합니다"
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
  
  def close_regis
    if @regis.present?
      @regis.fee_deadline = nil   
      @regis.state = "close"
      @regis.save
      redirect_to :back 
    else
      flash[:notice] = "수업 시작 요청을 실패하였습니다"
      redirect_to :back
    end
  end

  private
  def set_regis
    @regis = Registration.find(params[:id])
  end

  def timer_check
    all_regis = Registration.where(state: "open")
    all_regis.each do |each_regis|
      if each_regis.fee_deadline.present? && each_regis.fee_deadline < Time.now 
        each_regis.user_id = nil
        each_regis.save
      end
    end
  end
=begin
  def not_named_funtion_for_multiple_registraions
 #This is meant for users to be allowed to have more than a registration
    if current_user.courses.present?
      current_user.courses.each do |course|
        tmp_array = course.days.scan(/\w{3}/).to_a
        if @regis.course.days.include?tmp_array[0] or @regis.course.days.include?tmp_array[1]
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
          end
        else
          @tmp_apply = true
        end
      end
    end
  end
=end
end
