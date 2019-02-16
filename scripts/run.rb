#!/usr/bin/env ruby

rails_port = 5050
candone_port = 9000
path_to_js = "../../JS/candone"

puts 'Run Candone backend and frontend'


result = system("rails s -p #{rails_port} &")

Dir.chdir(path_to_js){
  result = system("yarn start")
}

unless result
  puts "Cannot execute script to run the application"
end