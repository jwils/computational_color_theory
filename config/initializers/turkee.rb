# Go to this page https://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key
# to retrieve your AWS/Mechanical Turk access keys.

AWSACCESSKEYID      = 'AKIAJCJRD4E2GHKB5FRQ'
AWSSECRETACCESSKEY  = 'O08nN4R+FEDm07QfobOJFIQGLQ3XYxgpGNUURnCf'

RTurk::logger.level = Logger::DEBUG
RTurk.setup(AWSACCESSKEYID, AWSSECRETACCESSKEY, :sandbox => (Rails.env == 'production' ? false : true))


Turkee::TurkeeTask.class_eval do
  def self.save_imported_values(model, param_hash)
    logger ||= Logger.new($stderr)
    logger.error(param_hash)
    logger.error(param_hash[model.to_s.underscore]["id"])
    m = model.find(param_hash[model.to_s.underscore]["id"])
    param_hash[model.to_s.underscore].delete("id")
    responses = []
    JSON(param_hash[model.to_s.underscore]["responses"]).each do |response|
      responses << Response.create do |r|
        r.survey = m
        r.question_id = response["question_id"]
        r.chosen_image = response["chosen_image"]
      end
    end
    param_hash[model.to_s.underscore]["responses"] = responses
    m.update_attributes(param_hash[model.to_s.underscore])
    m
  end
end
              
