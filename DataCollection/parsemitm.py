import sys
import csv



# Opening MITM output file and reading lines
file1 = open(sys.argv[1], 'r')
lines = file1.readlines()

containertype = sys.argv[1].split('.')[0].split('_')[-1]


# Holds the list of commands that the attacker runs
commands = []
attackerip = "N/A"
attackdate = "N/A"

entrancetime = "N/A"
exittime = "N/A"

# Processing read in lines to see what commands the attacker runs
curr_command = ""
for line in lines:
    trimmed = line.rstrip().split(' ')
    

    # Gathering attacker IP and attack date
    if 'Attempting to connect to the honeypot' in line:
        attackdate = trimmed[0]
        attackerip = trimmed[11]


    # Checking attacker sign in time
    if ('[LXC-Auth]' in trimmed):
        entrancetime = trimmed[1]

    # Dealing with noninteractive commands
    if ('[EXEC]' in trimmed):
        # print(' '.join(trimmed[trimmed.index('command:')+1:]))
        
        commands.extend(' '.join(trimmed[trimmed.index('command:')+1:]).split('; '))


    # Checking if we're a part of an attacker command
    if ( len(trimmed) > 6 and trimmed[5] == 'Attacker' and trimmed[6] == 'Keystroke:' ):
        if trimmed[7] == '[CR]': # End of a command
            commands.append(curr_command)
            curr_command = ""
        elif '[DEL]' in trimmed[7]: # Delete keystroke
            temp = trimmed[7]
            while '[DEL]' not in temp:
                index = temp.index('[DEL]')
                temp = temp[index-2:index-1] + temp[index+5:]
        elif '[ESC]' in trimmed[7]: # Excape keystroke - we cancel the command
            curr_command = ""
        elif '[Space]' in trimmed[7]: # Space keyword, we add a space
            curr_command += trimmed[7].replace("[Space]", " ")
        else: # Otherwise we just add to the current command
            curr_command += trimmed[7]

    # Exit time will be the last command in the script
    exittime = trimmed[1]


# Debugging print statement
# print("Attacker IP: " + attackerip)
# print("Date of attack: " + attackdate)
# print("Attack start time: " + entrancetime)
# print("Attack end time: " + exittime)
# print("Commands ran: " + str(commands))

# row = attackdate + ', ' + attackerip + ', ' + entrancetime + ', ' + exittime + ', ' + str(commands)

row = [attackdate, attackerip , entrancetime, exittime, commands]

outputfilename = 'attackers_' + containertype + '.csv'

# with open(outputfilename,'a') as fd:
#     fd.write(row)

if attackerip != "N/A" and attackdate != "N/A":
    writer = csv.writer(open(outputfilename, 'a'))
    writer.writerow(row)


# print(outputfilename)
# print(row)

print("Processed " + sys.argv[1])