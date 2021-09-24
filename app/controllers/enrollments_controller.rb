class EnrollmentsController < ApplicationController

  def index
    @enrollments = Enrollment.all
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end
end
