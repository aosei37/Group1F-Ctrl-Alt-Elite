import json
import sys

json_file = open("fake_info.txt")

customerdata = json.load(json_file)

counter = 1

orig_stdout = sys.stdout

for customer in customerdata:
    
    textfilename = "invoices/invoice" + '{:0>4}'.format(counter) + '.txt'
    f = open(textfilename, 'w')
    sys.stdout = f

    print("**************************************************************************************")

    print(" _   __ ___ ___________  ___      _____             ")
    print("| | / // _ \_   _| ___ \/ _ \    |_   _|            ")
    print("| |/ // /_\ \| | | |_/ / /_\ \     | | _ __   ___ 	INVOICE STATEMENT")
    print("|    \|  _  || | |    /|  _  |     | || '_ \ / __|	Date: " + customer['Date of Issue'])
    print("| |\  \ | | || | | |\ \| | | |_   _| || | | | (__ 	Invoice Number: " + str(counter))
    print("\_| \_|_| |_/\_/ \_| \_\_| |_( )  \___/_| |_|\___(_)  ")

    print("                             |/                     	BILL TO")

    print("10178 Shelia Shoals" + "                                    \t" + customer['First Name'] + " " + customer['Last Name'])
    print("East Johnview, GA 19047" + "                             	" + customer['Residence'].split('\n')[0])
    print("                                                        " + customer['Residence'].split('\n')[1])
    print("                                                       \t" + customer['Email'])

    print("======================================================================================")
    print( '{:<30s} {:<10s} {:<10s}     {:<10s}'.format("PRODUCT NAME", "QUANTITY", "UNIT PRICE", "TOTAL"))
    print( '{:<30s} {:<10s} {:<10s}     {:<10s}'.format("------------", "--------", "----------", "-----"))
    
    grandtotal = 0

    for item in customer['Items Purchased']:
        # print(item['Product Name']+"\t\t\t"+str(item['QTY'])+"\t"+str(item['Unit Price'])+"\t"+str(item['Total Cost']))
        print( '{:<30s} {:<10s} {:<10s}     {:<10s}'.format(item['Product Name'], str(item['QTY']), '$' + str(item['Unit Price']), '$' + "{:.2f}".format(item['Total Cost'])))
        grandtotal += item['Total Cost']
    
    print()
    print( '{:<30s} {:<10s} {:<11s}    {:<10s}'.format(' ', ' ', "GRAND TOTAL", '$' + "{:.2f}".format(grandtotal)))    

    print("======================================================================================")
    print()
    print("                     Thank you for shopping at Katra Electronics!")
    print()
    print("**************************************************************************************")

    counter += 1

sys.stdout = orig_stdout