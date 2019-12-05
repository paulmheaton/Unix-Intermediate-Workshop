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

}

END { 
        print  max, ",", min, ",", tot_heat_gain/24/60/60/1000  
    }
