require 'aws-sdk'

aws_data = YAML.load_file("/usr/local/chronus/bin/cred_details.yml")
bucket = AWS::S3.new(
  :access_key_id => aws_data["aws_access"],
  :secret_access_key => aws_data["aws_sercet"]).buckets[aws_data["bucket_name"]]

credentials = bucket.objects[aws_data["credentials"]]
paperclip   = bucket.objects[aws_data["paperclip"]]
s3          = bucket.objects[aws_data["s3"]]
amazon_s3   = bucket.objects[aws_data["amazon_s3"]]

File.open("/mnt/app/shared/config/.aws_credentials", "w") do |file|
  credentials.read do |chunk|
    file.write(chunk)
  end
end

File.open("/mnt/app/shared/config/.aws_amazon_s3", "w") do |file|
  amazon_s3.read do |chunk|
    file.write(chunk)
  end
end

File.open("/mnt/app/shared/config/.aws_paperclip", "w") do |file|
  paperclip.read do |chunk|
    file.write(chunk)
  end
end

File.open("/mnt/app/shared/config/.aws_s3", "w") do |file|
  s3.read do |chunk|
    file.write(chunk)
  end
end