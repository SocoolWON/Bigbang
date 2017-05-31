class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end
  
  def setting
    @teacher = current_teacher
  end

  def update
    teacher = Teacher.find(params[:id])
    teacher.univ = params[:univ]
    teacher.major = params[:major]
    teacher.interest = params[:interest]
    teacher.introduction = params[:introduction]
    teacher.paypal = params[:paypal]

    uploader = TeacherImageUploader.new
    picture = params[:picture]
    uploader.store!(picture)
    teacher.picture = uploader.url

    if teacher.save
      redirect_to courses_path 
    else
      redirect_to :back
    end
  end
end
