def execute_seed_files
  Dir[File.join(Rails.root, "db", "seeds", "*seeds.rb")].sort.each do |seed|
    puts "seeding - #{seed}. loading seeds, for real!" 
    load seed
  end
end

def admin
  Administrator.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
end

admin if Administrator.count < 1
execute_seed_files if ENV['EXECUTE_SEEDS'] == 'true'