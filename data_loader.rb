require 'cassandra'
require 'faker'
require 'parallel'

keyspace_name = 'spec_check'
table_name = 'user'
column_array = 'id, fname, lname, age, address, school'
cluster = Cassandra.cluster
session = cluster.connect(keyspace_name)

#Parallel.each((0..100).to_a, in_threads: 2) do |id|
id = 0
(0..100).each do |id|
  batch = session.batch do |b|
    1000.times do 
      b.add("INSERT INTO #{keyspace_name}.#{table_name} (#{column_array}) 
            VALUES (
            #{Cassandra::Uuid.new(id)}, \'#{Faker::Name.first_name.delete('\'')}\', 
              \'#{Faker::Name.last_name.delete('\'')}\', #{Faker::Number.number(digits: 1)}, \'#{Faker::Address.street_name.delete('\'')}\', \'#{Faker::University.name.delete('\'')}\')")
      id += 1
    end
  end
  session.execute(batch)
end
