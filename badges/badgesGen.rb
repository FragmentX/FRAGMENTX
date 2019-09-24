require 'httparty'
require 'json'

ARGV.each do |command|
  case command
  when "-p"
    puts "p comm"
  when "-f"
    puts "f comm"
  when "-w"
    puts "w comm"
  end
end


def getGeneralInformation
  return HTTParty.get('https://api.github.com/repos/FragmentX/FRAGMENTX').body
end

def getStatsInformation
  return HTTParty.get('https://api.github.com/repos/FragmentX/FRAGMENTX/stats/contributors').body
end

def getGeneralInformationFromLocalhost(file_name = "test_G.json")
  tmp_file_content = File.open(file_name, "r").read
  return tmp_file_content
end

def getStatsInformationFromLocalhost(file_name = "test_S.json")
  tmp_file_content = File.open(file_name, "r").read
  return tmp_file_content
end

def saveInformationGetRequest
  file = File.open("test_G.json", "w")
  file.puts getGeneralInformation
  file.close
end

def saveStatGetRequest
  file = File.open("test_S.json", "w")
  file.puts getStatsInformation
  file.close
end


#file = File.open("test.json", "w")
#file.puts responses.body
#file.close

puts JSON.parse(getStatsInformationFromLocalhost)[1]['author']

puts JSON.parse(getStatsInformationFromLocalhost)[0]['total']

#number_of_contributors = JSON.parse(responses.body)[0]['total']

#contributos_badge ="https://img.shields.io/badge/contributors-"+ (number_of_contributors.to_s) +"-blue"
