# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'CSV'
#### Initialize Sanity check ####

i = Image.create(:id => 1,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-100.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_15, fg_hsl_0_0_100'
i.save

i = Image.create(:id => 2,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-0.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_15, fg_hsl_0_0_0'
i.save

i = Image.create(:id => 3,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-33.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_40, fg_hsl_0_0_33'
i.save
i = Image.create(:id => 4,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-66.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_40, fg_hsl_0_0_66, middle_readable'
i.save

i = Image.create(:id => 5,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-0.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_65, fg_hsl_0_0_0'
i.save

i = Image.create(:id => 6,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-33.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_65, fg_hsl_0_0_33'
i.save

i = Image.create(:id => 7,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-0.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_90, fg_hsl_0_0_0, most_readable'
i.save

i = Image.create(:id => 8,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-100.png')
i.tag_list = 'sanity_check, bw_lightness, bg_hsl_0_0_90, fg_hsl_0_0_100, least_readable'
i.save

Question.create_questions_from_tags('sanity_check', 'sanity_check, exp1')

experiment = Experiment.create()
experiment.tag_list = "exp1, sanity_check"
experiment.questions = Question.tagged_with('sanity_check')
experiment.save

survey = Survey.new
current_id = 0
CSV.foreach('db/prelim_data.csv', { :headers => true }) do |row|
    if current_id != row[0].to_i
      current_id = row[0].to_i
      survey = Survey.new
      survey.ruler_height= row[1].to_i
      survey.ruler_width= row[2].to_i
      survey.save
      survey.experiment = experiment
    end

    question = Question.find(row[3].to_i - 112)
    answer = Response.new
    answer.chosen_image="img" +row[6]
    answer.question=question
    answer.survey=survey
    answer.save
end