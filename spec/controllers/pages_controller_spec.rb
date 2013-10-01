require 'spec_helper'

describe PagesController do
  describe '#show' do
    let(:page) { double('Page', title: 'Some title', content: 'Some content', slug: 'about') }

    before do
      allow(Page).to receive(:find_by_slug) { page }
    end

    it 'renders page based on slug' do
      get :show, slug: 'about'
      expect(assigns(:page)).to be(page)
      expect(response).to render_template("show")
    end
  end
end
