import json
import csv

json_file = open("fake_db.txt")

customerdata = json.load(json_file)

header = ['first_name', 'last_name', 'birthday', 'address', 'email', 'phone', 'years_as_customer']

counter = 0

f1 = open('customerdatabases/customers1.csv', 'w', newline='')
writer1 = csv.writer(f1)
f2 = open('customerdatabases/customers2.csv', 'w', newline='')
writer2 = csv.writer(f2)
f3 = open('customerdatabases/customers3.csv', 'w', newline='')
writer3 = csv.writer(f3)
f4 = open('customerdatabases/customers4.csv', 'w', newline='')
writer4 = csv.writer(f4)
f5 = open('customerdatabases/customers5.csv', 'w', newline='')
writer5 = csv.writer(f5)


writer1.writerow(header)
writer2.writerow(header)
writer3.writerow(header)
writer4.writerow(header)
writer5.writerow(header)

for customer in customerdata:
    data = [customer['First Name'], customer['Last Name'], customer['Birthdate (YYYY-MM-DD)'], 
            customer['Residence'].replace('\n', ' '), customer['Email'], customer['Phone Number'], 
            customer['Years as Member']]
    
    if counter < 200:
        writer1.writerow(data)
    elif counter >= 200 and counter < 400:
        writer2.writerow(data)
    elif counter >= 400 and counter < 600:
        writer3.writerow(data)
    elif counter >= 600 and counter < 800:
        writer4.writerow(data)
    else:
        writer5.writerow(data)

    counter += 1
