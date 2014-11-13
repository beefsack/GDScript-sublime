###################################
#   Gen 2014.11.12
#
#  This ruby script to update the completions
#   Requirement ruby gems:
#     HTTPClient
#     Nokogiri
#   $ ruby plugin_path/fetch_new_data.rb
##################################
require 'httpclient'
require 'nokogiri'
require 'fileutils'
require 'json'

base_url = 'https://github.com/okamstudio/godot/wiki/'
client = HTTPClient.new
response = nil
begin
  response = client.get(base_url+'class_list')
rescue e
  p "[Error] Get class failed : #{e}"
  p "- Press [Enter] to try again."
  STDIN.getc
  retry
end
doc = Nokogiri.parse(response.body)
path = File.dirname(__FILE__)
FileUtils.mkdir(path+"/Classes") unless File.exist?(path+"/Classes")
class_names = []
caches = []

doc.css('.markdown-body > table td a').each do |node|
  class_name = node.content
  p "Start to read #{class_name}..."
  unless class_name[/^@/] || caches.include?(class_name)
    class_names << class_name
    caches << class_name
  end
  sleep(5)
  url = base_url + node["href"]
  s_completions = []
  res_2 = nil
  begin
    res_s = client.get(url)
  rescue e
    p "[Error] Get #{class_name} failed : #{e}"
    p "- Press [Enter] to try again."
    STDIN.getc
    retry
  end
  s_doc = Nokogiri.parse(res_s.body)
  s_doc.css('.markdown-body > h3').each do |ele|
    if ele.content[/Member Functions/]
      parent = ele.parent
      list = parent.element_children[parent.element_children.index(ele) + 1]
      if list['class'] == 'task-list'
        list.css('li').each do |li|
          content = li.content
          method_name = 0
          args = []
          arg_key = 0
          content.gsub(/\w+|[^\w+]/).each do |k|
            if k[/^ +$/] && method_name == 0
              method_name = 1
            elsif k[/^\w+$/] && method_name == 1
              method_name = k
            elsif k[/\(|\)|,/] && arg_key == 0
              arg_key = 1
            elsif k[/^\w+$/] && arg_key == 1
              arg_key = 2
            elsif k[/^\w+$/] && arg_key == 2
              args << k
              arg_key = 0
            end
          end
          unless method_name.include?("#{method_name}(#{args*', '})")
            caches << "#{method_name}(#{args*', '})"
            unless method_name[/^_/]
              count = 0
              s_completions << {
                  trigger: method_name + "(#{args*', '})",
                  contents: "#{method_name}(#{args.map{|arg| "${#{count+=1}:#{arg}}"} * ', '})"
              }
            end
          end
          unless method_name.include?(method_name)
            caches << method_name
            s_completions << method_name
          end

          p "  << Method: #{method_name}(#{args*', '})"
        end
      end
    elsif ele.content[/Member Variables/]
      parent = ele.parent
      list = parent.element_children[parent.element_children.index(ele) + 1]
      if list['class'] == 'task-list'
        list.css('li').each do |li|
          content = li.content
          arr = content.gsub(/\w+/)
          if arr.size == 2
            unless caches.include?(arr[0])
              caches << arr[0]
              class_names << arr[0]
            end
            unless arr[0] == arr[1]
              unless caches.include?(arr[1])
                caches << arr[1]
                s_completions << arr[1]
              end
              p "  << Member: #{arr[1]}"
            end
          end
        end

      end
    elsif ele.content[/Numeric Constants/]
      parent = ele.parent
      list = parent.element_children[parent.element_children.index(ele) + 1]
      if list['class'] == 'task-list'
        list.css('li').each do |li|
          if li.content[/^\w+/]
            unless caches.include?(li.content[/^\w+/])
              caches << li.content[/^\w+/]
              s_completions << li.content[/^\w+/]
            end
            p "  << Numeric: #{li.content[/^\w+/]}"
          end
        end
      end
    end
  end

  if s_completions.size > 0
    class_path = "#{path}/Classes/#{class_name.sub('@', 'G_')}"
    FileUtils.mkdir(class_path) unless File.exist?(class_path)
    File.open(class_path + "/completions.sublime-completions", 'wb') do |f|
      f.write JSON.pretty_unparse(scope: "source.gdscript", completions: s_completions)
    end
  end
end



j_hash = {
    scope: "source.gdscript",
    completions: class_names
}
File.open(path+"/Classes/Class.sublime-completions", 'wb') do |f|
  f.write JSON.pretty_unparse(j_hash)
end

