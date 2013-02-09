# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'CSV'
#### Initialize Sanity check ####

Image.create(:id => 1,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-100.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_15, fg_hsl_0_0_100')
Image.create(:id => 2,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-0.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_15, fg_hsl_0_0_0')
Image.create(:id => 3,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-33.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_40, fg_hsl_0_0_33')
Image.create(:id => 4,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-66.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_40, fg_hsl_0_0_66, middle_readable')
Image.create(:id => 5,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-0.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_65, fg_hsl_0_0_0')
Image.create(:id => 6,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-33.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_65, fg_hsl_0_0_33')
Image.create(:id => 7,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-0.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_90, fg_hsl_0_0_0, most_readable')
Image.create(:id => 8,
             :image_name => '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-100.png',
             :tag_list => 'sanity_check, bw_lightness, bg_hsl_0_0_90, fg_hsl_0_0_100, least_readable')

Image.all(:order => :id).each do |image1|
  Image.all(:order => :id).each do |image2|
    unless image1 == image2
      Question.create(:img1 => image1, :img2 => image2, :tag_list => "sanity_check_exp1")
    end
  end
end


survey = Survey.new
current_id = 0
CSV.foreach('db/prelim_data.csv', { :headers => true }) do |row|
    if current_id != row[0].to_i
      current_id = row[0].to_i
      survey = Survey.new
      survey.ruler_height= row[1].to_i
      survey.ruler_width= row[2].to_i
      survey.save
    end

    question = Question.find(row[3].to_i - 112)
    answer = Response.new
    answer.chosen_image="img" +row[6]
    answer.question=question
    answer.survey=survey
    answer.save
end