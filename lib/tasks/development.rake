namespace :development do
  desc 'clears development.log file'
  task clear_log: :environment do
    File.open('log/development.log', 'w') {|file| file.truncate(0) }
    p 'development.log cleared successfully'
    # p User.create first_name: 'Steve', last_name:'Jobs', email:'prakash@lftechnology.com'
  end
end
