namespace :db do
  desc 'Reset Conter Cache'
  task :reset_counter => :environment do
    puts 'start rest counter task'
    Candidate.all.each do |candidate|
      Candidate.reset_counters(candidate.id, :vote_logs)
    end
    puts 'Done!'
  end
end