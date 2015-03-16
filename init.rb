require 'email_send_patch'

Redmine::Plugin.register :redmine_email_images do
  name 'Redmine Email Images plugin'
  author 'Dmitriy Kalachev'
  description 'Send images as attachments instead of using URL and getting a 403 error in email clients.'
  version '0.1.0'
  url 'http://github.com/dkalachov/redmine_email_images'
  author_url 'http://dkalachov.com'
end
