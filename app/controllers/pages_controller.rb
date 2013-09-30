
class PagesController < ApplicationController
  def index
    @request = request
  end

  def show
    render text: params
  end
end
