require 'httparty'
require 'json'

localhost_format = false

ARGV.each do |command|
  case command
  when "-p"
    puts "p comm"
  when "-v" # Verbose mode
    puts "f comm"
  when "-w" # Store POST request in localhost
    puts "w comm"
  when "-l" # Localhost mode
    localhost_format = true
  end
end

class BadgeGenerator

  @verbose_mode = false

  def initialize verbose_mode_tmp
    @verbose_mode = verbose_mode_tmp
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

  def getContributorsBadge localhost_format = false
    number_of_contributors = getNumberofcontributors localhost_format
    return crateBadge "contributors", (number_of_contributors.to_s), "blue"
  end

  def createContributorsSticker localhost_format = false
    contributors_badge_raw = getContributorsBadge localhost_format
    return crateReadmeSticker contributors_badge_raw
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

  def createFixedStickerList localhost_format = false
    stickerList = createContributorsSticker localhost_format
    return stickerList
  end

  def createFileStickerList

  end

  def createStickersList localhost_format = false
    return createFixedStickerList localhost_format
  end

  def createUpdateStickerText localhost_format = false
    sticker_list =  createStickersList localhost_format
    return readREADMEFile.sub /\[\/\/\]: # \(badges\)(.|\n)*\[\/\/\]: # \(badges\)/, "[//]: # (badges)\n" + sticker_list + "\n\n[//]: # (badges)"
  end

  def updateReadme localhost_format = false
    updated_readme_file = createUpdateStickerText localhost_format
    writeREADMEFile updated_readme_file
    if @verbose_mode
      puts updated_readme_file
    end
  end
end

generator = BadgeGenerator. new false

generator.updateReadme localhost_format

#puts JSON.parse(getStatsInformationFromLocalhost)[1]['author']

