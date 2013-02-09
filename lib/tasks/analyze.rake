task :update_questions => :environment do
  wrong_answer_count = Hash.new
  wrong_answer_count.default= 0

  Question.where('id < ?', 57).each do |question|
    p1 = question.responses.where(:chosen_image => 'img1').count()
    p2 = question.responses.where(:chosen_image => 'img2').count()
    variance = 2*Math.sqrt(p1 * p2 / 169.0**3)
    puts [p1, p2, variance].join(" ")
    if variance < 0.04
      if p1 > p2
        img = "img2"
      else
        img = "img1"
      end


      question.responses.where(:chosen_image => img).each do |response|
        wrong_answer_count[response.survey] += 1
      end
    end
  end

  Survey.all().each() do |survey|
    left_count = survey.responses.where(:chosen_image => 'img1').count()
    right_count = survey.responses.where(:chosen_image => 'img2').count()
    puts [survey.id, left_count, right_count, wrong_answer_count[survey]].join(",")
  end
end