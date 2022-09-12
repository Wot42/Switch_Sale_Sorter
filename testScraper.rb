require "json"
require "open-uri"
require 'date'
require "nokogiri"


html_file = URI.open("https://www.nintendo.co.uk/Games/Nintendo-Switch-download-software/Birds-and-Blocks-1844667.html").read
html_doc = Nokogiri::HTML(html_file)
discription = []
pics = []
# html_doc.search(".game-section-content .content p").each do |element1|
#   p element1.text.strip
#   p "p"
# end
# html_doc.search(".page-img img").each do |element1|
#   unless  element1.attribute(":alt") || element1.attribute("v-bind:alt")
#     p element1.attribute("data-xs").value
#     p "p"
#   end
# end

html_doc.search("script").each do |element1|

    p element1
    p "p"

end




# @html_doc.search(".standard-card-new__article-title").each do |element|
#   @pics.push(element.attribute("href").value)
# end
# <img class="img-responsive" alt="NSwitchDS_BirdsAndBlocks_01" src="https://fs-prod-cdn.nintendo-europe.com/media/images/06_screenshots/games_5/nintendo_switch_download_software_2/nswitchds_birdsandblocks/NSwitchDS_BirdsAndBlocks_01_TM_Standard.jpg" data-xs="https://fs-prod-cdn.nintendo-europe.com/media/images/06_screenshots/games_5/nintendo_switch_download_software_2/nswitchds_birdsandblocks/NSwitchDS_BirdsAndBlocks_01_TM_Standard.jpg" style="opacity: 1;">
# <img class="modal-img img-responsive" src="https://fs-prod-cdn.nintendo-europe.com/media/images/06_screenshots/games_5/nintendo_switch_download_software_2/nswitchds_birdsandblocks/NSwitchDS_BirdsAndBlocks_01.jpg">
# .mediagallery-image-overlay


# https://fs-prod-cdn.nintendo-europe.com/media/images/06_screenshots/games_5/nintendo_switch_download_software_2/nswitchds_birdsandblocks/NSwitchDS_BirdsAndBlocks_01_TM_Standard.jpg
# https://fs-prod-cdn.nintendo-europe.com/media/images/06_screenshots/games_5/nintendo_switch_download_software_2/nswitchds_birdsandblocks/NSwitchDS_BirdsAndBlocks_01.jpg
