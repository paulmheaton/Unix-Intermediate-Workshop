#!/bin/bash

echo This is a script to process tabular experimental data and output results in a usable format.;

echo TOT argument= ${#args[@]};

echo The script is called: $0;  # this is always the script file itself

echo The first script argument is: $1;   # We will use this argument for a switch


echo The second script argument is: $2;   # this will be the data to be processed
FILE=$2 #set the file to process variable

if [[ $1 == "--help" ]]; then
     echo USAGE: process_data.sh [options] FILENAME;    
     echo OPTIONS:;
     echo -c = Output cumulative data;
     exit;
fi


if [[ $1 == "-f" ]]; then
     echo 'Output to file selected';
     CUMULATIVE=true;
fi


if [[ ! -e $1 ]] && [[ ! -e $2 ]]; then
     echo 'directory does not exist!';
     exit;
fi


if [[ -e $1 ]]; then
     echo 'Default behaviour - no switch';
    FILE=$1;
    echo "File to process= $FILE";
fi

echo  process command line argument directly;
while IFS= read -r line
do 
	echo "$line";
done < "$FILE"

echo read in file to variable then process;
mydata="$(cat $FILE)";
for line in $mydata; do
  echo $line
done;


awk 'BEGIN{
max=0
min=1000
FS=","
tot_heat_gain=0
}
{   
    joules_gain=($2-$4)*4200*100
    tot_heat_gain+=joules_gain
    if($2<min){min=$2}
    if($2>max){max=$2}

    print "reading=",$2,"   max=",max, "min=",min,"   joules=",joules_gain
}
END { print "The maximum temperature was  ", max
	print "\nThe minimum temperature was  ", min 
	print "\nThe total heat gain for the day was ", tot_heat_gain/24/60/60/1000 ,"Kw"  }
' $FILE;


echo DONE;