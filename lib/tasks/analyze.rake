require 'csv'

namespace :analyze do
  task :print, [:exp_id] => :environment do |t, args|
    CSV.open(File.join(Rails.root, 'public/results.csv'), "wb") do |csv|
      csv << %w[image_1_id image_2_id chosen]
      Experiment.find(args[:exp_id]).questions.each do |question|
         question.image_one_count.times{csv << [question.img1_id, question.img2_id, 1]}
         question.image_two_count.times{csv << [question.img1_id, question.img2_id, 2]}
      end
    end
  end

  task :print_all_csvs => :environment do
    Experiment.all.each do |exp|
      filename = "results/results_v#{exp.id}.csv"
      File.open(File.join(Rails.root, filename), 'w') {|f| f.write(exp.questions.generate_csv(exp.id)) }
    end
  end

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

  task :add_results => :environment do
    BASE_DIR = File.join(Rails.root, 'prepro/')
    Dir.glob(BASE_DIR + "*.*") do |my_text_file|
      File.open(my_text_file) do |file|
        exp_number = file.readline[1]
        noise = file.readline
        while not file.eof?
          image_info = file.readline.split(",")
          r = Result.new
          r.experiment_id= exp_number
          r.image_id =  image_info[0]
          r.psi =  image_info[1]
          r.noise = noise
          r.save
        end
      end
    end
  end
end
