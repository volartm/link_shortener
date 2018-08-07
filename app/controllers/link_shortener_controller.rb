class LinkShortenerController < ApplicationController

  def shorten
    link = params['link']
    link.to_s
    host_uri = "#{request.host}".to_s

    if !link.nil? && !link.include?(host_uri)
      link.downcase!
    end

    unless link.nil?

      db_row = Link.find_by(link: link)

      if db_row.nil?
        new(link)
      else
        redirect_to controller: 'link_show', action: 'show', link_hash: db_row['link_hash']
      end

    end
  end

  def new data
    host_uri = "#{request.host}".to_s

    db_row = Link.new
    db_row.link = data
    if data.include?(host_uri)
      db_row.link_hash = data.sub!("#{request.protocol}#{request.host}:#{request.port}/", "")
    else
      db_row.link_hash = Base64.urlsafe_encode64(random_salt + data)[0...8]
    end

    db_row.save

    redirect_to controller: 'link_show', action: 'show', link_hash: db_row.link_hash
  end

  def random_salt
    random = File.new('/dev/random', 'r')
    random.read(16)
    salt = random.read(8)
    random.close
    salt
  end
end
