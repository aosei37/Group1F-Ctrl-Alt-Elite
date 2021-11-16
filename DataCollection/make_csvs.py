# ONLY RUN ONCE EVER

import csv

files_writer = csv.writer(open('attackers_files.csv', 'w'))
database_writer = csv.writer(open('attackers_database.csv', 'w'))
resources_writer = csv.writer(open('attackers_resources.csv', 'w'))
control_writer = csv.writer(open('attackers_control.csv', 'w'))

row = ['attackdate', 'attackerip' , 'entrancetime', 'exittime', 'commands']

files_writer.writerow(row)
database_writer.writerow(row)
resources_writer.writerow(row)
control_writer.writerow(row)