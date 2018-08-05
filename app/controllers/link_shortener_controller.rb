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
    db_raw = Link.new
    db_raw.link = data
    db_raw.link_hash = Base64.urlsafe_encode64(data)[0...6]
    db_raw.save

    redirect_to controller: 'link_show', action: 'show', link_hash: db_raw.link_hash
  end
end
