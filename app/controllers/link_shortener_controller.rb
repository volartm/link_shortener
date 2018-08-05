class LinkShortenerController < ApplicationController
  def shorten
    puts("link - " + params['link'])
  end
end
