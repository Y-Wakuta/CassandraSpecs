require 'mysql2'
require 'faker'

database_name = 'spec_check'
table_name = 'user'
column_array = 'id, fname, lname, age, address, school'
#conn = Mysql2::Client.new(:socket => '/var/lib/mysql/mysql.sock', :host => 'localhost', :username => 'root',:password => 'root',:database => database_name)
conn = Mysql2::Client.new(:host => '127.0.0.1', :port => '3306', :username => 'root',:password => 'root',:database => database_name)

id = 0
(0..1000).each do |id|
  conn.query("INSERT INTO #{database_name}.#{table_name} (#{column_array}) 
            VALUES (
        #{id}, \'#{Faker::Name.first_name.delete('\'')}\', 
              \'#{Faker::Name.last_name.delete('\'')}\', #{Faker::Number.number(digits: 1)}, \'#{Faker::Address.street_name.delete('\'')}\', \'#{Faker::University.name.delete('\'')}\')")
  id += 1
end

conn.close
