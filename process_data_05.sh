#!/bin/bash

echo This is a script to process tabular experimental data and output results in a usable format.;


echo TOTAL arguments= ${#args[@]};

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


if [[ $1 == "-c" ]]; then
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

FOUT=${FILE%.csv}_cum.csv;

read -e -p "Enter output filename: " -i $FOUT;
FOUT=$REPLY;

echo File will be written as "$FOUT"

echo Processing....;

awk -f process_data_04.awk $FILE >> "$FOUT"
 
echo  

echo DONE;