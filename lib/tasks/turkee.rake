require 'rake'
require 'turkee'

namespace :turkee do
  task :launch_exp, [ :num_assignments, :exp_id] => :environment do |t, args|
    URL = 'http://www.upenncolortheory.com'
    hit = Turkee::TurkeeTask.create_hit(URL,"Color Theory Survey Exp#{args[:exp_id]}", 'You will be asked to make binary comparisons between images', Survey,
                                        args[:num_assignments], 0.03, 10, 1, {:approval_rate => { :gt => 90 }})
    hit.experiment_id = args[:exp_id]
    hit.save
    puts "Hit created ( #{hit.hit_url} )."
  end
end
