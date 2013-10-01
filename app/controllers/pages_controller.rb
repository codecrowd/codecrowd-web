
class PagesController < ApplicationController
  def index
    @request = request
  end

  def show
    @page = Page.find_by_slug(params[:slug])
  end
end
