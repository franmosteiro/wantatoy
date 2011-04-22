Paperclip.interpolates(:s3_eu_url) do |att, style|
    "#{att.s3_protocol}://s3-eu-west-1.amazonaws.com/#{att.bucket_name}/#{att.path(style)}"
end
AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com"