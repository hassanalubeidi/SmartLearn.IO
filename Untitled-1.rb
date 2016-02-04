testpaper = TestPaper.find(params[:testpaper_id]) #get testpaper object
url = params[:test_paper_url] #get testpaper url

params =  CGI::parse(url) # convert URL into Ruby Hash
questions =  params["doclist"].join.split("|").compact # Split doclist parameter by |
question_exampro_ids = url.get_doclist().get_doclist_ids()

question_exampro_ids.each_with_index do |exampro_id, index|
    if exampro_id in database?
        testpaper.main_questions << MainQuestion.find_by(exampro_id: question)
    else 
        
    end
    
        
end


questions.each_with_index do |question, index|
    if MainQuestion.where(exampro_id: question).count == 0 then #if not in database, parse paper and put into database
    if question_meta_data.root.q.at_css("[qid='#{question}']") != nil then #Validation
        template_url = url.scan(/.*?(?=doclist)doclist/).join #???
        q_url = url.gsub(/doclist\s*(((?!doclist|&).)+)/, "doclist=#{urlify(question)}") #Create Mainquestion URL
        question_html = Nokogiri::HTML(open(q_url)) #Create nokogiri object from MQ URL
        m_url = q_url.gsub(/type.?\=[A-Z]/, "type=M") #Create Mainquestion markscheme URL
        mark_scheme_html = Nokogiri::HTML(open(m_url)) #Create Nokogiri object from MQ Markscheme URL
        
        mainquestion = MainQuestion.create( #Create MainQuestion Rails entity with grabbed info
            exampro_id: question,
            test_paper_id: testpaper.id,
            answer_html: mark_scheme_html.to_html,
            html: question_html.to_html
            )
        
        testpaper.main_questions << mainquestion #Append created MainQuestion Rails object to TestPaper
        testpaper.save
        marks = question_html.content.scan(/\([1-9]*\)/) 
    
        if question_html.css("table") #Valid HTML?
        question_html.css("table").each_with_index do |table, index| #Loop over Tables within MainQuestion HTML
        ques_id = table.content.scan(/\([a-h]\)|\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\)/).join() #Grab position data from HTML
        if ques_id.scan(/\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\)/).size > 1 then #Positions array contains multiple positions?
            #Catch questions which contain position = a)b) etc
            fix_marks = table.content.scan(/\(\d\)/) #Grab mark string within question HTML
            actual_marks = 0 #initiate var
            fix_marks.each do |m| #Loop over mark strings
            mm = m.scan(/\d/).join.to_i #Find integer within the string
            actual_marks += mm #Add to actual_marks
            end
            ques = Question.new( #Create Question Rails entity based on previous data
                main_question_id: mainquestion.id,
                total_marks: actual_marks,
                html: "#{table.to_html} <strong>Warning, the above question contains formatting errors</strong>",
                position: ""
                )
                ques.save
        else #Positions array is valid (contains <1 position)
            begin
            if ques_id.strip.scan(/^(\(i\)|\(ii\)|\(iii\)|\(iv\)|\(v\))/).size < 1 then #Position is single nested
                $last_good = ques_id.scan(/\([a-h]\)/).join
                ques = Question.new(
                main_question_id: mainquestion.id,
                total_marks: marks[index].scan(/[0-50]/).join.to_i,
                html: table.to_html,
                position: ques_id
                )
                ques.save

            else
                Question.create( #Position is double nested
                main_question_id: mainquestion.id,
                total_marks: marks[index].scan(/[0-50]/).join.to_i,
                html: table.to_html,
                position: "#{$last_good}#{ques_id}" #Last good single nested position + this position
                )
            end
            rescue NoMethodError #Don't break pls

            end
            end
        end

        end
        question_objectives_ids = question_meta_data.root.q.at_css("[qid='#{question}']").attribute("index7").to_s.split("| ") # find objective exampro ids
        question_objectives_ids.each do |o_id| #Loop over objective exampro ids
        unless objectives.root.level1.css("[id='#{o_id.sub(/[a-z]/, "")}']") == nil then #Unless objective == topic
            topic = Topic.find_or_create_by( name: objectives.root.level1.at_css("[id='#{o_id.strip.sub(/[a-z]/, "")}']").attribute("data").to_html.scan(/".*?"/).join.gsub(/\"/, ""), subject: testpaper.subject) #Find or create topic with trimmed objective exampro id
        end
        objective = Objective.find_or_create_by( #Find or create an objective with the found objective id
            name: objectives.root.css("[id='#{o_id.strip}']").attribute("data").to_html.scan(/".*?"/).join.gsub(/\"/, ""),
            topic: topic
        )
        
        mainquestion.objectives << objective #Append objective with MainQuestion's objectives
        mainquestion.save
        objective.main_questions << mainquestion #Append main question to Objective's mainquestion
        objective.save

        end
    end
    else #else reuse the question in the database
    testpaper.main_questions << MainQuestion.find_by(exampro_id: question)
    end
end
redirect_to test_paper_path(testpaper) #Redirect to testpaper 