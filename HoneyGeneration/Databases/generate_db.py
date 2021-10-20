from faker import Faker
import faker_commerce
import json
import os
import random as r
import datetime 

def listToString(s): 
    str1 = "" 
    for ele in s: 
        str1 += str(ele)  
    return str1 


def generate_db_file():
    faker = Faker()
    domain_names = ["@gmail.com", "@yahoo.com", "@aol.com", "@msn.com", 
                "@hotmail.com", "@live.com", "@outlook.com"]
    main_list = []

    for i in range(1000): # Can change the range to generate more
        d = {}
        ph_no = []
        flip = r.randint(0,2)
        flip2 = r.randint(0,6)
        email_choice = r.randint(1,4)
        years_as_member = r.randint(1,10)

        ph_no.append(r.randint(6, 9)) # Generates numbers
        for i in range(1, 10):
            ph_no.append(r.randint(0, 9))

        if flip == 0: # Generates name
            first_name = faker.first_name_female()
            last_name = faker.last_name_female()
        elif flip == 1:
            first_name = faker.first_name_male()
            last_name = faker.last_name_male()
        else:
            first_name = faker.first_name_nonbinary()
            last_name = faker.last_name_nonbinary()

        if email_choice == 1:
            email = f"{first_name[0]}.{last_name}{domain_names[flip2]}"
        elif email_choice == 2:
            email = f"{first_name}.{last_name[0]}{domain_names[flip2]}"
        elif email_choice == 3:
            email = f"{first_name}{last_name}{domain_names[flip2]}"
        else:
            emal = f"{first_name}.{last_name}{domain_names[flip2]}"


        d['First Name'] = first_name
        d['Last Name'] = last_name
        d['Birthdate (YYYY-MM-DD)'] = str(faker.date_of_birth(tzinfo=None, minimum_age=18, maximum_age=67))
        d['Residence'] = faker.address()
        d['Email'] = email
        d['Phone Number'] = listToString(ph_no)
        d['Years as Member'] = years_as_member
        
        main_list.append(d)

    new_json = json.dumps(main_list, indent = 2)
    with open("fake_db.txt", "w") as out:
        json.dump(main_list, out, indent = 2)
    

if __name__ == "__main__":
    generate_db_file()
