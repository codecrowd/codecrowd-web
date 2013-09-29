require 'spec_helper'

describe ApplicationController do
  it 'sets page title' do
    controler = ApplicationController.new
    controller.page_title = 'Test title'
    expect(controller.page_title).to eq 'Test title'
  end
end
