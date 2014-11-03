require 'aws-sdk'

aws_data = HashWithIndifferentAccess.new(YAML.load_file(""))
s3 = AWS::S3.new(
  :access_key_id => aws_data['access_key'],
  :secret_access_key => aws_data['secret_key'])


bucket      = node[:ivin_application][:credentials_bucket]
credentials = s3.buckets[bucket[:bucket_name]].objects[bucket[:credentials]]
paperclip   = s3.buckets[bucket[:bucket_name]].objects[bucket[:paperclip]]
s3          = s3.buckets[bucket[:bucket_name]].objects[bucket[:s3]]
amazon_s3   = s3.buckets[bucket[:bucket_name]].objects[bucket[:amazon_s3]]

File.open("/mnt/app/shared/config/.credentials") do |file|
  credentials.read do |chunk|
    file.write(chunk)
  end
end

File.open("/mnt/app/shared/config/.amazon_s3") do |file|
  amazon_s3.read do |chunk|
    file.write(chunk)
  end
end

File.open("/mnt/app/shared/config/.paperclip") do |file|
  paperclip.read do |chunk|
    file.write(chunk)
  end
end

File.open("/mnt/app/shared/config/.paperclip") do |file|
  s3.read do |chunk|
    file.write(chunk)
  end
end