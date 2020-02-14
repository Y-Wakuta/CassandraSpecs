cqlsh -e "CREATE KEYSPACE spec_check WITH REPLICATION = {'class':'SimpleStrategy','replication_factor':1};"
cqlsh -e "CREATE TABLE spec_check.user (id uuid, fname text, lname text, age int, address text, school text, PRIMARY KEY(age, id, fname));"
