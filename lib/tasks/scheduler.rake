desc "This task is called by the Heroku scheduler add-on to send daily text messages"
task :send_messages => :environment do
  puts "Sending Text Messages..."
  Debt.send_automated_messages
  puts "Sending Texts Completed."
end