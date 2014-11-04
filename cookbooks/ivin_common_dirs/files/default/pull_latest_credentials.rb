require 'aws-sdk'

aws_data = HashWithIndifferentAccess.new(YAML.load_file("/usr/local/chronus/bin/cred_details.yml"))
s3 = AWS::S3.new(
  :access_key_id => aws_data["aws_access"],
  :secret_access_key => aws_data["aws_sercet"])

credentials = s3.buckets[aws_data["bucket_name"]].objects[aws_data["credentials"]]
paperclip   = s3.buckets[aws_data["bucket_name"]].objects[aws_data["paperclip"]]
s3          = s3.buckets[aws_data["bucket_name"]].objects[aws_data["s3"]]
amazon_s3   = s3.buckets[aws_data["bucket_name"]].objects[aws_data["amazon_s3"]]

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

File.open("/mnt/app/shared/config/.s3") do |file|
  s3.read do |chunk|
    file.write(chunk)
  end
end