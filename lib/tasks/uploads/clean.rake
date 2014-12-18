require 'fileutils'

namespace :uploads do
  desc 'Clean the uploads directory'
  task clean: :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE pictures")

    ActiveRecord::Base.connection.execute("TRUNCATE TABLE documents")

    FileUtils.rm_rf(Dir.glob(Rails.root.join('public', 'uploads', '*')))
  end
end
