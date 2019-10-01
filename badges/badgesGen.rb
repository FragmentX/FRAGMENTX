require 'httparty'
require 'json'

localhost_format = false

ARGV.each do |command|
  case command
  when "-p"
    puts "p comm"
  when "-f"
    puts "f comm"
  when "-w"
    puts "w comm"
  when "-l"
    puts localhost_format = true
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

def saveGenInfoGetRequest(file_name = "test_G.json")
  writeFile(file_name, getGeneralInformation)
end

def saveStatInfoGetRequest(file_name = "test_S.json")
  writeFile(file_name, getStatsInformation)
end

def writeFile(file_name = "test.json", data)
  file = File.open(file_name, "w")
  file.puts data
  file.close
end

def readREADMEFile
  tmp_file_content = File.open("../README.md", "r").read
  return tmp_file_content
end

def writeREADMEFile(data)
  file = File.open("../README.md", "w")
  file.puts data
  file.close
end

def getNumberofcontributors localhost_format = false

  if localhost_format
    return JSON.parse(getStatsInformationFromLocalhost)[0]['total']
  else
    return JSON.parse(getStatsInformation)[0]['total']
  end
end

def crateBadge label, message, color
  return "https://img.shields.io/badge/" + label + "-" + message + "-" + color
end

def crateReadmeSticker stickerURL, stickerLink = nil
  if stickerLink.nil?
    stickerLink = stickerURL
  end
  return "[![security](" + stickerURL + ")]("+ stickerLink +")"
end

number_of_contributors = getNumberofcontributors localhost_format

contributors_badge = crateBadge "contributors", (number_of_contributors.to_s), "blue"

contributors_badge = crateReadmeSticker contributors_badge

updated_readme_file = readREADMEFile.sub /\[\/\/\]: # \(badges\)(.|\n)*\[\/\/\]: # \(badges\)/, "[//]: # (badges)\n" + contributors_badge + "\n\n[//]: # (badges)"

writeREADMEFile updated_readme_file
puts updated_readme_file
#puts JSON.parse(getStatsInformationFromLocalhost)[1]['author']

