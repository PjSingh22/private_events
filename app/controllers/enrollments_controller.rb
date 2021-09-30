class EnrollmentsController < ApplicationController

  def create
    event = Event.find_by_id(params[:event_id])
    user = User.find_by_id(params[:user_id])
    attendance = event.attendees.create(event_id: event.id, user_id: user.id)
    if attendance.save
      redirect_to event_path(event)
    else
      flash[:notice] = "You are already registered for this event"
      redirect_to event_path(event)
    end
  end

  def destroy
    event = Event.find(params[:event_id])
    enrollment = Enrollment.find(params[:id])
    if current_user == event.creator
      enrollment.destroy
      flash[:notice] = "You have unreserved from the event!"
    end
  end

  def update
    @event = Event.find(params[:event_id])
    @enrollment = Enrollment.find_by(event_id: params[:event_id], user_id: current_user.id)
    if @enrollment
      flash[:notice] = "Thank you for signing up for the '#{@event.name}'!"
    else
      flash[:alert] = 'Your name is not on the invitation list'
    end

    redirect_to event_path(@event)
  end

  private
  def enrollment_params
    params.require(:enrollment).permit(:event_id, :user_id)
  end
end
