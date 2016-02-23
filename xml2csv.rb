require 'xmlsimple'
require 'nokogiri'
require 'csv'

file = File.read('test.xml')
doc = Nokogiri::XML(file)
CSV.open("result.csv", "wb")  do |csv|
  xml = doc.xpath("//network_object[Class_Name='network']/Name[starts-with(., 'Ness-RO')]/..")
  xml.each do |magical_element|
    config = XmlSimple.xml_in(magical_element.to_xml, { 'KeyAttr' => 'name' })
  csv << [config.to_s.gsub(/\"/,"").gsub(/{/,"").gsub(/}/,"").gsub(/=>\[\]/,"").gsub(/=>/,",").gsub(/\[/,"").gsub(/\]/,"").gsub(/, /,",")]
  end
end
