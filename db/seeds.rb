# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
#### Initialize Sanity check ####
BASE_DIR = File.join(Rails.root, 'public/exp_img/')
i = Image.create(:id => 1)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-100.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_15, bg_hsl_0_0_100'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 15 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 100 )
i.save

i = Image.create(:id => 2)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-0.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_15, bg_hsl_0_0_0'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 15 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 0 )
i.save

i = Image.create(:id => 3)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-33.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_40, bg_hsl_0_0_33'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 40 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 33 )
i.save
i = Image.create(:id => 4)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-66.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_40, bg_hsl_0_0_66, middle_readable'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 40 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 66 )
i.save

i = Image.create(:id => 5)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-0.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_65, bg_hsl_0_0_0'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 65 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 0 )
i.save

i = Image.create(:id => 6)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-33.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_65, bg_hsl_0_0_33'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 65 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 33 )
i.save

i = Image.create(:id => 7)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-0.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_90, bg_hsl_0_0_0, most_readable'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 90 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 0 )
i.save

i = Image.create(:id => 8)
i.image_name.store!(File.open(File.join(BASE_DIR, '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-100.png')))
i.tag_list = 'sanity_check, bw_lightness, fg_hsl_0_0_90, bg_hsl_0_0_100, least_readable'
i.fg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 90 )
i.bg_color = Color.find_or_create_by_color_type_and_val1_and_val2_and_val3('hsl', 0, 0, 100 )
i.save

experiment = Experiment.create()
experiment.name= 'Sanity Check Exp'
experiment.tag_list = 'exp1, sanity_check'
experiment.questions = Question.create_questions_from_images(Image.all)
experiment.save

survey = Survey.new
current_id = 0
CSV.foreach(File.join(Rails.root, 'db/prelim_data.csv'), { :headers => true }) do |row|
    if current_id != row[0].to_i
      current_id = row[0].to_i
      survey = Survey.new
      survey.ruler_height= row[1].to_i
      survey.ruler_width= row[2].to_i
      survey.experiment = experiment
      survey.save
    end

    question = Question.find_or_create_by_images(Image.find(row[4].to_i), Image.find(row[5].to_i))
    answer = Response.new
    answer.chosen_image="img" +row[6]
    answer.question=question
    answer.survey=survey
    answer.reversed = if question.img1_id == row[4].to_i then 0 else 1 end
    answer.save
end