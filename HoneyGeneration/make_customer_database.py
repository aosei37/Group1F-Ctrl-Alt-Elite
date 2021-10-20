import json
import csv

json_file = open("fake_db.txt")

customerdata = json.load(json_file)

header = ['first_name', 'last_name', 'birthday', 'address', 'email', 'phone', 'years_as_customer']

f = open('customers.csv', 'w', newline='')
writer = csv.writer(f)

writer.writerow(header)

for customer in customerdata:
    data = [customer['First Name'], customer['Last Name'], customer['Birthdate (YYYY-MM-DD)'], 
            customer['Residence'].replace('\n', ' '), customer['Email'], customer['Phone Number'], 
            customer['Years as Member']]
    
    writer.writerow(data)

