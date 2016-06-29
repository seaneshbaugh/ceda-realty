namespace :db do
  desc 'Truncate the database tables'
  task truncate: :environment do
    excluded_tables = %w(ar_internal_metadata schema_migrations)

    ActiveRecord::Base.connection.tables.reject { |table_name| excluded_tables.include?(table_name) }.each do |table_name|
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name}")
    end
  end
end
