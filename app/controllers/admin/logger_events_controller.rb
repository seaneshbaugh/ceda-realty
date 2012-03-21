require "will_paginate"

class Admin::LoggerEventsController < Admin::AdminController
	def index
		per_page = params[:per_page]

		per_page ||= 25

		params[:submit] = nil

		if !params[:sort].nil? and !params[:order].nil?
			sort_order = params[:sort].to_s + " " + params[:order].to_s
		else
			sort_order = "created_at DESC"
		end

		if !params[:search].blank?
			search = "%" + params[:search] + "%"

			@logger_events = LoggerEvent.paginate(:page => params[:page], :per_page => per_page, :order => sort_order, :conditions => ['description LIKE ?', search])
		else
			@logger_events = LoggerEvent.paginate(:page => params[:page], :per_page => per_page, :order => sort_order)
		end

		@page_title = "Event Log"

		if mobile_browser?
			render :action => "index_mobile"
		end
	end

	def show
		@logger_event = LoggerEvent.find_by_id(params[:id])

		if @logger_event.nil?
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("event")

			redirect_to(admin_logger_events_url) and return
		end

		@page_title = "View Event - " + @logger_event.id.to_s

		if mobile_browser?
			render :action => "show_mobile"
		end
	end

	def destroy
		@logger_event = LoggerEvent.find_by_id(params[:id])

		if !@logger_event.nil?
			LoggerEvent.destroy(@logger_event)

			flash[:type] = "success"

			flash[:notice] = notice_message_destroyed("event")

			redirect_to(admin_logger_event_url) and return
		else
			flash[:type] = "error"

			flash[:notice] = error_message_could_not_find("event")

			redirect_to(admin_logger_event_url) and return
		end
	end

	def destroy_multiple
		@logger_events = Person.find(params[:logger_event_ids])

		for logger_event in @logger_events
			LoggerEvent.destroy(logger_event)
		end

		flash[:type] = "success"

		flash[:notice] = notice_message_destroyed("all events")

		redirect_to(admin_logger_event_url) and return
	end
end
