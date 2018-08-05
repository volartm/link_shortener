class LinkShortenerController < ApplicationController
  def shorten
    link = params['link']
    link.to_s.downcase!

    unless link.nil?
      sql = "SELECT\nlink\nFROM\npublic.links\nWHERE\nlinks.link ="
      sql += "'" + link + "'" + "\n"
      sql += "ORDER BY\nlinks.link\nASC\nLIMIT 1;"

      records_array = ActiveRecord::Base.connection.exec_query(sql)

      if records_array.empty?
        new(link)
      end

    end
  end

  def new data
    m = Link.new
    m.link = data
    m.link_hash = Base64.urlsafe_encode64(data)[0...6]
    m.save
  end
end
