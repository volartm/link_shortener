class Link < ApplicationRecord
  validates_presence_of   :link, :message => "You must specify a URL."
  validates_format_of     :link, :with => %r{https?:\/\/[\S]+}i, :message => "The URL must start with http://, https://"
end
