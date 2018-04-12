#!/bin/bash
echo
echo "Yo! We're going to ping facebook a bunch of times and test the parity of the latency as measured in 10^(-1) milliseconds."

echo

echo "If the parity is even we'll add 1 to a counter. If odd we'll subtract 1. Then we'll try to test how well this approximates a coin toss."

echo

keyflag=1

while [ $keyflag -eq 1 ]
do

read -n1 -r -p "Press space to continue or Ctrl+C to quit. " key

   if [ "$key" = '' ]; then
      keyflag=0
   else
      keyflag=1
   fi
echo
done

 
counter=0
numflag=1
echo
echo "Initialised counter at 0."

echo

while [ $numflag -eq 1 ]
do
echo
echo "How many times do you want to run the loop? "
echo
read numloop

   if ! [[ "$numloop" =~ ^[0-9]+$ ]]
       then
           echo "Sorry, positive integers only!";
       else
           numflag=0    
   fi
echo
done

i=1        #portable loop,{1..$numloop} won't work

while [ "$i" -le "$numloop" ]; do
   echo "Pinging..."
   a=$(ping -c 1 facebook.com | grep rtt | cut -d"/" -f 5 | grep -o '.$');  
   if [  $(expr $a % 2) -eq 0 ];
       then
           echo "Last digit is $a - even parity!";
           counter=$((counter+1));
       else
           echo "Last digit is $a - odd parity!";
           counter=$((counter-1));
   fi

i=$(($i + 1))

  # if [$a % 2 -eq=0];
  # then 
  #    echo "even";
  #    counter=$((counter+1));
  # else
  #    echo "odd";
  #    counter=$((counter-1));
  # fi
done
echo
echo "Counter finished at $counter."
