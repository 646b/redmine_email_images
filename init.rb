require 'htmlentities'
coder = HTMLEntities.new
INVISIBLE_EMAIL_HEADER = "&#8203;" * 20
INVISIBLE_EMAIL_HEADER_DECODED = coder.decode(INVISIBLE_EMAIL_HEADER)
FIND_IMG_SRC_PATTERN = /(<img[^>]+src=")([^"]+)("[^>]*>)/

require 'email_send_patch'
require 'email_receive_inline_patch'

Redmine::Plugin.register :redmine_email_images do
  name 'Redmine Email Images plugin'
  author 'Dmitriy Kalachev'
  description 'Send images as attachments instead of using URL and getting a 403 error in email clients.'
  version '0.1.1'
  url 'http://github.com/dkalachov/redmine_email_images'
  author_url 'http://dkalachov.com'
end
