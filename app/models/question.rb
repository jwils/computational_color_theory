class Question < ActiveRecord::Base
  belongs_to :img1, :class_name => Image, :foreign_key => :img1_id
  belongs_to :img2, :class_name => Image, :foreign_key => :img2_id
  has_and_belongs_to_many :experiments
  has_many :responses
  attr_accessible  :img1_id, :img2_id
  acts_as_taggable

  scope :find_by_ids, lambda {|image1_id, image2_id|
    where('(img1_id = ? and img2_id = ?) or (img1_id = ? and img2_id = ?)', image1_id, image2_id, image2_id, image1_id)
  }

  scope :random, lambda{|num_questions| order('RANDOM()').limit(num_questions)}

  def filter_response(opts = {})
    resp = self.responses
    resp.by_experiment unless opts[:experiment_id].nil?
  end

  def image_one_count(opts = {})
    resp = filter_response(opts)
    resp.where(:chosen_image => 'img1', :reversed => 0).count + resp.where(:chosen_image => 'img2', :reversed => 1).count
  end

  def image_two_count(opts = {})
    resp = filter_response(opts)
    resp.where(:chosen_image => 'img2', :reversed => 0).count + resp.where(:chosen_image => 'img1', :reversed => 1).count
  end

  def self.images
    joined_tables = Image.joins(:img1_questions).joins(:img2_questions)
    joined_tables.where('questions.id in (?) or  img2_questions_images.id in  (?)',
                       select(:id), select(:id)).uniq

  end

  def self.generate_csv(exp_id)
    CSV.generate(options) do |csv|
      csv << %w[image_1_id image_2_id chosen]
      all.each do |question|
        question.image_one_count(:experiment_id => exp_id).times{csv << [question.img1_id, question.img2_id, 1]}
        question.image_two_count(:experiment_id => exp_id).times{csv << [question.img1_id, question.img2_id, 2]}
      end
    end
  end

  def randomize_to_json
    img1_json = {:id => img1.id, :image_name => img1.image_name.url}
    img2_json = {:id => img2.id, :image_name => img2.image_name.url}
    hash = {}
    hash[:id] =  id

    if rand > 0.5
      hash[:d] = 0
      hash[:img1] = img1_json
      hash[:img2] = img2_json
    else
      hash[:d] = 1
      hash[:img2] = img1_json
      hash[:img1] = img2_json
    end
    hash
  end

  def self.create_questions_from_images(images)
    questions = []
    images.each_with_index do |image1, index|
      images[(index + 1)..-1].each do |image2|
        questions << Question.find_or_create_by_images(image1, image2)
       end
    end
    questions
  end

  def self.find_or_create_by_images(image1, image2)
    Question.find_by_img1_id_and_img2_id(image1.id, image2.id) ||
        Question.find_or_create_by_img1_id_and_img2_id(image2.id, image1.id)
  end

  def self.find_group_by_tags(tags)
    questions = Question.tagged_with(tags, :any => true).order("RANDOM()").compact
    questions_2 = Question.order("RANDOM()").tagged_with(tags, :any => true)
    questions_2.reject do |question|
      if questions.include?(question.matching_question)
        questions.delete(question)
      end
    end
  end
end
