class Question < ActiveRecord::Base
  belongs_to :img1, :class_name => Image, :foreign_key => :img1_id
  belongs_to :img2, :class_name => Image, :foreign_key => :img2_id
  has_and_belongs_to_many :experiment
  has_many :responses
  attr_accessible  :img1_id, :img2_id
  acts_as_taggable

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
    q = Question.find_by_img1_id_and_img2_id(image1.id, image2.id)
    if q.nil?
      q = Question.find_or_create_by_img1_id_and_img2_id(image2.id, image1.id)
    end
    return q
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

  def self.get_random_questions(num_questions)
    self.order("RANDOM()").limit(num_questions)
  end
end
