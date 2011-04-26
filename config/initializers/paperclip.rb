# Por si alguna vez queremos meter como parte de la url de aws un campo del "toy"
#Paperclip.interpolates(:contact) do |att, style| 
#  att.instance.contact.to_s 
#end 
#Paperclip.interpolates(:s3_protected_eu_url) do |attachment, style|
#  time_limit = attachment.options[:s3_url_time_limit] || 15.minutes
#  attachment.interface.get_link "#{att.s3_protocol}://s3-eu-west-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}", time_limit
#end
Paperclip.interpolates(:s3_eu_url) do |att, style|
    "#{att.s3_protocol}://s3-eu-west-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
end
AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"