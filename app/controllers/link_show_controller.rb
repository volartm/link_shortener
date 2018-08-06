class LinkShowController < ApplicationController
  def show
    @base_uri = "#{request.protocol}#{request.host}:#{request.port}"

    @short_link_text = @base_uri + '/' + params['link_hash'].to_s
    @short_link = @base_uri + '/' + params['link_hash'].to_s
  end

  def show_original

    sql = "SELECT\nlink\nFROM\npublic.links\nWHERE\nlinks.link_hash ="
    sql += "'" + params['link_hash'] + "'" + ';'

    records_array = ActiveRecord::Base.connection.exec_query(sql)
    link = records_array[0]['link']

    redirect_to(link, status: 301)

  end

end
