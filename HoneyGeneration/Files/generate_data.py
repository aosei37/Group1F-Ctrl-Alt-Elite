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


def generate_json_file():
    faker = Faker()
    domain_names = ["@gmail.com", "@yahoo.com", "@aol.com", "@msn.com", 
                "@hotmail.com", "@live.com", "@outlook.com"]
    flip = 0
    flip2 = 0
    main_list = []
    start_date = datetime.date(1999, 1, 1)
    end_date = datetime.date(2020, 2, 1)

    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days

    for i in range(10): # Can change the range to generate more
        d = {}
        items_list = []
        current_item = {}
        ph_no = []
        name_choice = r.randint(0,2)
        domain_choice = r.randint(0,6)
        total_items = r.randint(2,10)
        random_number_of_days = r.randrange(days_between_dates)

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

        for i in range(1, total_items + 1):
            faker.add_provider(faker_commerce.Provider)
            current_item = {}
            quantity = r.randint(1,11)
            dollar_amount = round(r.uniform(5.50, 550.50), 2)
            current_item['Product Name'] = faker.ecommerce_name()
            current_item["QTY"] = quantity
            current_item['Unit Price'] = dollar_amount
            current_item['Total Cost'] = dollar_amount * quantity
            
            items_list.append(current_item)

        d['Date of Issue'] = str(start_date + datetime.timedelta(days=random_number_of_days))
        d['First Name'] = first_name
        d['Last Name'] = last_name
        d['Residence'] = faker.address()
        d['Email'] = f"{first_name}.{last_name}{domain_names[flip2]}"
        d['Phone Number'] = listToString(ph_no)
        d['Items Purchased'] = items_list
        

        main_list.append(d)

    new_json = json.dumps(main_list, indent = 2)
    with open("fake_info.txt", "w") as out:
        json.dump(main_list, out, indent = 2)
    

if __name__ == "__main__":
    generate_json_file()
