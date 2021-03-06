class LinkShowController < ApplicationController
  def show
    @base_uri = "#{request.protocol}#{request.host}:#{request.port}"

    @short_link_text = @base_uri + '/' + params['link_hash'].to_s
    @short_link = @base_uri + '/' + params['link_hash'].to_s
  end

  def show_original
    link = Link.find_by(link_hash: params['link_hash']).link

    redirect_to(link, status: 301)

  end

end
