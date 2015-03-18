require 'pathname'

class InlineImagesEmailInterceptor
  def self.delivering_email(message)
    text_part = message.text_part
    html_part = message.html_part

    if html_part
      related = Mail::Part.new
      related.content_type = 'multipart/related'
      related.add_part html_part
      html_part.body = html_part.body.to_s.gsub(/<body[^>]*>/, "\\0 " << INVISIBLE_EMAIL_HEADER.html_safe)
      html_part.body = html_part.body.to_s.gsub(FIND_IMG_SRC_PATTERN) do
        image_url = $2
        attachment_url = image_url
        attachment_object = Attachment.where(:id => Pathname.new(image_url).dirname.basename.to_s).first
        if attachment_object
          image_name = attachment_object.filename
          related.attachments.inline[image_name] = File.read(attachment_object.diskfile)
          attachment_url = related.attachments[image_name].url
        end

        $1 << attachment_url << $3
      end

      # multipart/alternative
      # - text/plain
      # - multipart/relative
      # -- text/html
      # -- image/*
      message.parts.clear
      message.parts << text_part
      message.parts << related
    end
  end
end

ActionMailer::Base.register_interceptor(InlineImagesEmailInterceptor)

