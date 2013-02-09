class Question < ActiveRecord::Base
  belongs_to :img1, :class_name => Image, :foreign_key => :img1_id
  belongs_to :img2, :class_name => Image, :foreign_key => :img2_id
  belongs_to :experiment
  has_many :responses
  attr_accessible  :img1_id, :img2_id
  acts_as_taggable

  def matching_question
    Question.find_by_img1_id_and_img2_id(self.img2_id, self.img1_id)
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

  def self.create_questions_from_tags(image_tags,questions_tags)
    image_tags = image_tags.split(",") if image_tags.kind_of? String
    questions_tags = questions_tags.split(",") if questions_tags.kind_of? String
    results = []
    images = Image.tagged_with(image_tags, :any => true)
    images.each_with_index do |image1, i1|
      images.each_with_index do |image2, i2|
        unless i1 == i2
          q = Question.find_or_create_by_img1_id_and_img2_id(image1.id,
                              image2.id)
          q.tag_list << questions_tags
          q.save
          results << q
        end
      end
    end
    return results
  end
end
