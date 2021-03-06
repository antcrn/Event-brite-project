class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :logged_in?, only: %i[ new edit update destroy ]

  def index
    @events = Event.all.reorder('start_date ASC')
  end

  def show
    @num_participant = Attendance.where(event_id: params[:id]).count
  end

  def new
    @event = Event.new
  end

  def edit
    if params[:administrator].nil?
      @admin = @event.administrator
    else 
      @admin = params[:administrator]
    end
    only_administrator(@admin)
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    only_user?(current_user)
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    only_user?(current_user)
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def only_administrator(administrator)
    if administrator.nil?
      redirect_to events_path
    else
      only_user?(administrator)
    end
  end
    
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :location, :price, :start_date, :duration, :administrator_id)
  end
end

