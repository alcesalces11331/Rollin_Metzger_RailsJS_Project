class EventsApiController < ApplicationController

    def index
        events = Event.where(quest_id: params[:quest_id])
        quest = Quest.find_by(id: params[:quest_id])
        render json: events
    end

    def create
        event = Event.create
        render json: event, status: 201
    end

end