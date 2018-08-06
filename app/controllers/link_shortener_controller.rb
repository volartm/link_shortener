class LinkShortenerController < ApplicationController

  def shorten
    link = params['link']
    link.to_s
    host_uri = "#{request.host}".to_s

    if !link.nil? && !link.include?(host_uri)
      link.downcase!
    end

    unless link.nil?
      sql = "SELECT\nlink,\nlink_hash\nFROM\npublic.links\nWHERE\nlinks.link ="
      sql += "'" + link + "'" + "\n"
      sql += "ORDER BY\nlinks.link\nASC\nLIMIT 1;"

      records_array = ActiveRecord::Base.connection.exec_query(sql)

      if records_array.empty?
        new(link)
      else
        redirect_to controller: 'link_show', action: 'show', link_hash: records_array[0]['link_hash']
      end

    end
  end

  def new data
    host_uri = "#{request.host}".to_s

    db_raw = Link.new
    db_raw.link = data
    if data.include?(host_uri)
      db_raw.link_hash = data.sub!("#{request.protocol}#{request.host}:#{request.port}/", "")
    else
      db_raw.link_hash = Base64.urlsafe_encode64(random_salt + data)[0...8]
    end

    db_raw.save

    redirect_to controller: 'link_show', action: 'show', link_hash: db_raw.link_hash
  end

  def random_salt
    random = File.new('/dev/random', 'r')
    random.read(16)
    salt = random.read(8)
    random.close
    salt
  end
end
