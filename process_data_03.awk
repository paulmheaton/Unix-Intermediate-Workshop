BEGIN{

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

END { 
        print "The maximum temperature was  ", max
        print "\nThe minimum temperature was  ", min
        print "\nThe total heat gain for the day was ", tot_heat_gain/24/60/60/1000 ,"KwJ"  
    }
