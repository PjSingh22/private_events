class EnrollmentsController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    user = User.find(params[:user_id])
    enrollment = Enrollment.new(event_id: event, user_id: user)
    if enrollment.save
      flash[:notice] = "You have successfully enrolled in #{event.name}"
    else
      flash[:notice] = "You are already enrolled in #{event.name}"
    end
    redirect_to event_path(event)
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
    event = Event.find(params[:event_id])
    @enrollment = Enrollment.find_by(event_id: event.id, user_id: current_user.id)
    if @enrollment
      flash[:notice] = "You have successfully updated your reservation!"
    else
      flash[:alert] = "You have not updated your reservation!"
    end
    redirect_to event_path(event)
  end

  private
  def enrollment_params
    params.require(:enrollment).permit(:event_id, :user_id)
  end
end
