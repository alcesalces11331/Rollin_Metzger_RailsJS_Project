class EventsController < ApplicationController
    before_action :logged_in?
    include EventsHelper

    def index
        if params[:quest_id] == nil
            @events = Event.all
            @quests = []
            @events.each do |e|
                quest = Quest.find_by(id: e.id)
                @quests << quest
                # we have all the quests here
            end
            render 'index'
        else
            @events = Event.where(quest_id: params[:quest_id])
            @quest = Quest.find_by(id: params[:quest_id])
        end
    end

    def show
        @event = Event.find_by(id: params[:id])
        @quest = Quest.find_by(id: params[:quest_id])
    end

    def new
        @event = Event.new
        @quest = Quest.find_by(id: params[:quest_id])
    end

    def create
        @event = Event.new(events_params)
        @quest = Quest.find_by(id: params[:quest_id].to_i)
        @event.quest_id = @quest.id

        if @event.save
            redirect_to quest_path(@quest)
        else
            render 'new'
        end
    end

    def edit
        @event = Event.find_by(id: params[:id])
        @quest = Quest.find_by(id: @event.quest_id)
    end

    def update
        @event = Event.find_by(id: params[:id])
        @event.update(events_params)
        @quest = Quest.find_by(id: @event.quest_id)
        redirect_to quest_event_path(@quest, @event)
    end

    def destroy
        @event = Event.find_by(id: params[:id])
        quest_id = @event.quest_id
        @event.destroy
        redirect_to events_index_path
    end

    def new_quest_event
        @event = Event.new
        render layout: false
    end

    private

    def events_params
        params.require(:event).permit(:name, :description, :combat, :social, :search, :quest_id, :questId)
    end
end
