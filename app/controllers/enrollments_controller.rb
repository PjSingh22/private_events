class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    event = Event.find(params[:event_id])
    user = current_user
    enrollment = Enrollment.new(event_id: event.id, user_id: user.id)
    if enrollment.save
      redirect_to event_path(event)
    else
      flash[:alert] = 'something went wrong...'
    end
  end

  def destroy
    enrollment = Enrollment.find(params[:id])
    enrollment.destroy
    redirect_to event_path(enrollment.event)
  end

  def update
    event = Event.find(params[:event_id])
    user = User.find(current_user.id)
    if Enrollment.where(event_id: event.id, user_id: user.id).exists?
      Enrollment.destroy(Enrollment.where(event_id: event.id, user_id: user.id).first.id)
      flash[:notice] = 'You have unreserved from the event!'
    else
      Enrollment.create(event_id: event.id, user_id: user.id)
      flash[:notice] = 'You have successfully reserved the event!'
    end
    redirect_to event_path(event)
  end

  private
  def enrollment_params
    params.require(:enrollment).permit(:event_id, :user_id)
  end
end
