import random
import sys

year = 2000

orig_stdout = sys.stdout

while year < 2020:

    textfilename = "incomestatements/incomestatement" + str(year) + '.txt'
    f = open(textfilename, 'w')
    sys.stdout = f

    print("********************************************************************")
    print("                            KATRA, Inc.")
    print("                         INCOME STATEMENT")
    print("                 For Year Ended September 28, " + str(year))
    print("====================================================================")

    net_sales = random.randint(100000, 999999)
    cost_of_sales = random.uniform(0.3, 0.6)*net_sales
    gross_profit = net_sales - cost_of_sales

    operating_expenses = random.uniform(0.15, 0.3)*cost_of_sales
    general_expenses = random.uniform(0.3, 0.6)*operating_expenses
    total_operating_expenses = operating_expenses + general_expenses
    operating_income = gross_profit - total_operating_expenses

    other_income = random.randint(100, 1000)
    interest_expense = random.randint(10000, 30000)
    income_before_taxes = operating_income + other_income - interest_expense

    income_tax_expense = 0.21*income_before_taxes

    net_income = income_before_taxes - income_tax_expense

    
    print( '{:<40s}\t\t{:<8s}'.format("Net Sales", '$' + "{:.2f}".format(net_sales)))
    print( '{:<40s}\t\t{:<8s}'.format("Cost of Sales", '$' + "{:.2f}".format(cost_of_sales)))
    print( '{:<40s}\t\t{:<8s}'.format("\tGROSS PROFIT", '$' + "{:.2f}".format(gross_profit)))
    print()
    print( '{:<40s}\t\t{:<8s}'.format("Selling and Operating Expenses", '$' + "{:.2f}".format(operating_expenses)))
    print( '{:<40s}\t\t{:<8s}'.format("General and Administrative Expenses", '$' + "{:.2f}".format(general_expenses)))
    print( '{:<40s}\t\t{:<8s}'.format("\tTOTAL OPERATING EXPENSES", '$' + "{:.2f}".format(total_operating_expenses)))
    print( '{:<40s}\t\t{:<8s}'.format("\tOPERATING INCOME", '$' + "{:.2f}".format(operating_income)))
    print()
    print( '{:<40s}\t\t{:<8s}'.format("Other Income", '$' + "{:.2f}".format(other_income)))
    print( '{:<40s}\t\t{:<8s}'.format("Interest Expense", '$' + "{:.2f}".format(interest_expense)))
    print( '{:<40s}\t\t{:<8s}'.format("\tINCOME BEFORE TAXES", '$' + "{:.2f}".format(income_before_taxes)))
    print()
    print( '{:<40s}\t\t{:<8s}'.format("Income Tax Expense", '$' + "{:.2f}".format(income_tax_expense)))
    print()
    print( '{:<40s}\t\t{:<8s}'.format("NET INCOME", '$' + "{:.2f}".format(net_income)))

    print("********************************************************************")



    year += 1

sys.stdout = orig_stdout