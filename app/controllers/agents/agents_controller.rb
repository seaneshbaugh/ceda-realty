class Agents::AgentsController < ApplicationController
  before_filter :authenticate_user!

  layout 'agents'

  def index
  end
end
