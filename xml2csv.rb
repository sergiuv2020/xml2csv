require 'xmlsimple'
require 'nokogiri'
require 'csv'

file = File.read('test.xml')
doc = Nokogiri::XML(file)
csv = CSV.open("result.csv", "wb")

filtered_xml = doc.xpath("//network_object[Class_Name='network']/Name[starts-with(., 'Ness-RO')]/..")
filtered_xml.each do |magical_element|
  element_hash = XmlSimple.xml_in(magical_element.to_xml, { 'KeyAttr' => 'name' })
  stripped_hash = element_hash.to_s.gsub(/\"/,"").gsub(/{/,"").gsub(/}/,"").gsub(/=>\[\]/,"").gsub(/\[/,"").gsub(/\]/,"").gsub(/, /,",").gsub(/=>/,",")
csv << [stripped_hash]
end
