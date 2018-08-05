class LinkShowController < ApplicationController
  def show
    @short_link_text = 'http://0.0.0.0/' + params['link_hash'].to_s
    @short_link = 'http://0.0.0.0/' + params['link_hash'].to_s
  end
end
