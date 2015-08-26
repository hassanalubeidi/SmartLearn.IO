module ParsePapers
  require "nokogiri"
  require 'open-uri'
  require 'rest-client'
  require 'json'


  class Qquestion
    def initialize(q_num, url)
      @page = Nokogiri::HTML(open(url))
      @q_num = q_num
      @url = url
    end

    def question_image
      begin
      html = all("questions")[q_num - 1].join("")
      return html_2_image(html)
      rescue
        return nil
    end

    def question_html
      begin
      html = all("questions")[q_num - 1].join("")
      return final_html(html)
      rescue
        return nil
    end

    def q_num
      @q_num
    end

    def answer_image
      begin
      html = all("answers")[q_num - 1].join("")
      return html_2_image(html)
      rescue
        return nil
    end
    def answer_html
      begin
      html = all("answers")[q_num - 1].join("")
      return final_html(html)
      rescue
        return nil
    end

    def exam_notes_image
      begin
      html = all("exam note")[q_num - 1].join("")
      return html_2_image(html)
      rescue
        return nil
    end
    def exam_notes_html
      begin
      html = all("exam note")[q_num - 1].join("")
      return final_html(html)
      rescue
        return nil
    end

    def source
      begin
        info = (all("info")[q_num - 1]).first
        return get_detail("Question source", info)
      rescue
        return nil
    end

    def description
      begin
      info = (all("info")[q_num - 1]).first
      return get_detail("Description", info)
      rescue
        return nil
    end

    def marks
      begin
      info = (all("info")[q_num - 1]).first
      return get_detail("Marks", info).to_i
      rescue
        return nil
    end

    def topic
      begin
      info = (all("info")[q_num - 1]).first
      return get_detail("Topic", info)
      rescue
        return nil
    end

    def type
      begin
      info = (all("info")[q_num - 1]).first
      return get_detail("Type", info)
      rescue
        return nil
    end


    private

    def html_2_image(html)
      
      b =  Net::HTTP.post_form(URI.parse('http://api.page2images.com/html2image'), {'p2i_html'=> final_html(html),
                                              'p2i_key' => '0c9242f0d0aeafa3',
                                              'p2i_url' => @url,
                                              'p2i_screen' => "715x0",
                                              'p2i_size' => "715x0" } )
      status = JSON.parse(b.body)["status"]

      until status == "finished" do 
        b = Net::HTTP.post_form(URI.parse('http://api.page2images.com/html2image'), {'p2i_html'=> final_html(html),
                                             'p2i_key' => '0c9242f0d0aeafa3',
                                             'p2i_url' => @url,
                                             'p2i_screen' => "715x0",
                                             'p2i_size' => "715x0" } )
        sleep 3
        status = JSON.parse(b.body)["status"]
      end
      
      return JSON.parse(b.body)["image_url"]
    end
    def final_html(html)
      return '<head><link href="http://content.doublestruck.eu/style/ds.css" rel="stylesheet" type="text/css"></head><body>' +  html + '</body>'
    end


    def all(type)
      types = ["questions", "answers", "exam note", "info"]
      
      hash = Hash[types.map.with_index.to_a]    # => {"a"=>0, "b"=>1, "c"=>2}
      next_type = types[((hash[type]).to_i + 1)]
      objects = []
      
      objects = []
      find_starts_of(type).each_with_index do |i, index|
        unless i == find_starts_of(type).last then

          object = []
          for x in i..(find_starts_of(type)[index + 1] - 1)
            object.push(@page.css("table")[x])
          end
          unless parse_type(type) == "N" then
            object.map! { |x| x.to_html}
          end
          
          objects.push object

        else
          if parse_type(type) == "N" then
            object = []
            object.push(@page.css("table")[i])
            objects.push object
          else

            object = []
            for x in i..(find_starts_of(next_type).first - 1)

              object.push(@page.css("table")[x]) unless x == nil
            end
            object.map! { |x| x.to_html}
            objects.push object
          end
          
        end
        
      end
      return objects
    end

    def is_start_of(type, table)
      unless table.css("b") == nil then
        a = table.css("b").to_a
        objects = []
        a.each do |x|
          if /#{parse_type(type)}[1-9]/.match(x.content) != nil then 
            objects.push(x)
          end
        end
        if objects.count > 0 then
         return true
        else return false
        end
      else
        return false
      end
    end

    def find_starts_of(type)
      g = 0
      test = []
      objects = []
      @page.css("table").each_with_index do |object, index|
        if is_start_of(type, object)  then
          objects.push index
        end
      end
      return objects
    end

    def get_detail(detail, info)
      info.css(".indent1new").each do |x|
        if /#{detail}:/.match(x.content)
          y = x.content
          y.slice! "#{detail}: "
          return y
        end
      end
    end

    def parse_type(type)
      case type
      when "question", "a question", "questions"
        type = "Q"
      when "marking" , "answer" , "markings" , "answers"
        type = "M"
      when "exam note", "exam notes" , "exam_note"
        type = "E"
      when "note" , "info"
        type = "N"
      else 
        raise "invalid type in parse_types"
      end
      return type
    end 
  end

  public
  def number_of_questions(url)
      g = 0
      test = []
      objects = []
      page = Nokogiri::HTML(open(url))
      page.css("table").each_with_index do |object, index|
        if is_start_of(type, object)  then
          objects.push index
        end
      end
      return objects.count
    end

    def is_start_of(type, table)
      unless table.css("b") == nil then
        a = table.css("b").to_a
        objects = []
        a.each do |x|
          if /#{parse_type(type)}[1-9]/.match(x.content) != nil then 
            objects.push(x)
          end
        end
        if objects.count > 0 then
         return true
        else return false
        end
      else
        return false
      end
    end

    def parse_type(type)
      case type
      when "question", "a question", "questions"
        type = "Q"
      when "marking" , "answer" , "markings" , "answers"
        type = "M"
      when "exam note", "exam notes" , "exam_note"
        type = "E"
      when "note" , "info"
        type = "N"
      else 
        raise "invalid type in parse_types"
      end
      return type
    end 
end
