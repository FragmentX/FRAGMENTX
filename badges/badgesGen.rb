require 'httparty'
require 'json'

localhost_format = false
verbose_mode     = false
write_post_stats = false

ARGV.each do |command|
  case command
  when "-v" # Verbose mode
    verbose_mode = true
  when "-w" # Store POST request in localhost
    write_post_stats = true
  when "-l" # Localhost mode
    localhost_format = true
  end
end

class BadgeGenerator

  @verbose_mode     = false
  @localhost_format = false

  def initialize verbose_mode_tmp, localhost_format_tmp
    @verbose_mode     = verbose_mode_tmp
    @localhost_format = localhost_format_tmp
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

  def getNumberofcontributors
    if @localhost_format
      return JSON.parse(getStatsInformationFromLocalhost)[0]['total']
    else
      return JSON.parse(getStatsInformation)[0]['total']
    end
  end

  def getContributorsBadge
    number_of_contributors = getNumberofcontributors
    return crateBadge "contributors", (number_of_contributors.to_s), "blue"
  end

  def createContributorsSticker
    contributors_badge_raw = getContributorsBadge
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

  def createFixedStickerList
    stickerList = createContributorsSticker
    return stickerList
  end

  def createFileStickerList

  end

  def createStickersList
    return createFixedStickerList
  end

  def createUpdateStickerText
    sticker_list =  createStickersList
    return readREADMEFile.sub /\[\/\/\]: # \(badges\)(.|\n)*\[\/\/\]: # \(badges\)/, "[//]: # (badges)\n" + sticker_list + "\n\n[//]: # (badges)"
  end

  def updateReadme
    updated_readme_file = createUpdateStickerText
    writeREADMEFile updated_readme_file
    if @verbose_mode
      puts updated_readme_file
    end
  end
end

generator = BadgeGenerator. new false, localhost_format

generator.updateReadme

if write_post_stats
  generator.getStatsInformationFromLocalhost
  generator.saveGenInfoGetRequest
end

#puts JSON.parse(getStatsInformationFromLocalhost)[1]['author']

