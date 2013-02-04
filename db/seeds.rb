# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Image.create(:id => 1, :image_name => '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-100.png')
Image.create(:id => 2, :image_name => '1fdb4a1f7f_Arial_hsl0-0-15_24pt_hsl0-0-0.png')
Image.create(:id => 3, :image_name => '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-33.png')
Image.create(:id => 4, :image_name => '1fdb4a1f7f_Arial_hsl0-0-40_24pt_hsl0-0-66.png')
Image.create(:id => 5, :image_name => '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-0.png')
Image.create(:id => 6, :image_name => '1fdb4a1f7f_Arial_hsl0-0-65_24pt_hsl0-0-33.png')
Image.create(:id => 7, :image_name => '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-0.png')
Image.create(:id => 8, :image_name => '1fdb4a1f7f_Arial_hsl0-0-90_24pt_hsl0-0-100.png')


Image.order_by(:id).each do |image1|
  Image.order_by(:id).each do |image2|
    Question.create(:img1 => image1, :img2 => image2)
  end
end