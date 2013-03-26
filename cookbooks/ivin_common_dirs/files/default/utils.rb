module Ec2onrails
  module Utils
    def self.run(command)
      result = system command
      raise("error: #{$?}") unless result
    end
  
    def self.rails_env
      `/usr/local/chronus/bin/rails_env`.strip
    end
    
    def self.hostname
      `hostname -s`.strip
    end
  end
end