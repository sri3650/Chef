require 'fileutils'
require 'rubygems'
require 'git'
require 'yaml'

directory = "/mnt/app/cucumbers"
cucumber_origin_branches = ["r4_stage", "r4_develop"]
git = Git.init

unless File.directory?(directory)
  Dir.mkdir(File.join(directory))
  puts "Creating clone"
  begin
    git = Git.clone("git@github.com:ChronusCorp/IVIN.git", directory)
    puts "Clone created"
  rescue Exception => e
    puts "Folder removed as clone failed."
    Dir.rmdir(File.join(directory))
  end
else
  git = Git.init(directory)
end

cucumber_origin_branches.each do |branch|

  cucumber_branch = "#{branch}_cucumbers"

  puts "Checkout #{branch}"
    git.checkout(branch)
    git.pull("git@github.com:ChronusCorp/IVIN.git", branch)

  puts "Remove #{branch}_cucumbers from remote and local"
    if git.branches.remote.collect(&:name).include?(cucumber_branch)
      git.push('origin', ":#{cucumber_branch}")
    end
    if git.branches.local.collect(&:name).include?(cucumber_branch)
      git.branch(cucumber_branch).delete
    end

  puts "Checkout new #{cucumber_branch} from #{branch}"
    git.branch(cucumber_branch).checkout

  puts "Change tddium file"
    data = YAML.load_file ( directory + "/config/tddium.yml" )
    data[:tddium][:test_pattern] = ["features/*.feature"]
    File.open("/mnt/app/cucumbers/config/tddium.yml", 'w') { |f| YAML.dump(data, f) }
    git.add("/mnt/app/cucumbers/config/tddium.yml")
    git.commit("Running cucumber tests on #{Time.now.to_datetime}")

  puts "Push new #{cucumber_branch} to remote"
    git.push('origin', cucumber_branch)
end