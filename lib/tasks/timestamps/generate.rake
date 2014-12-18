namespace :timestamps do
  desc 'Generate timestamps for file fixtures.'
  task :generate do
    n = ENV['N'].to_i

    if n <= 0
      n = 1
    end

    n.times do
      current_time = Time.now

      puts "#{current_time.to_i}#{current_time.usec}".ljust(16, '0')

      sleep(rand(1000000).to_f / 1000000.0)
    end
  end
end
