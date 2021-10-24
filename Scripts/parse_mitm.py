
# Opening MITM output file and reading lines
file1 = open('samplemitm.txt', 'r')
lines = file1.readlines()

# Holds the list of commands that the attacker runs
commands = []

# Processing read in lines to see what commands the attacker runs
curr_command = ""
for line in lines:
    trimmed = line.rstrip().split(' ')

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

print(commands)
