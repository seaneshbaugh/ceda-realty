class Agent::AgentController < ApplicationController
	layout :get_agent_layout

	skip_before_filter :maintain_session_and_user

	before_filter :maintain_session_and_user, :is_agent?

	def index
		@page_title = "CEDA Mobile Office"

		@last_ten_events = LoggerEvent.find(:all, :order => "created_at DESC", :limit => 10)

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	private

	def get_agent_layout
		if mobile_browser?
			return "agent_mobile"
		else
			return "agent"
		end
	end
end
