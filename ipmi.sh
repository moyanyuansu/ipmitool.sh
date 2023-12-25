#!/bin/bash
# Set the username and password variables
username="user"
password="pwd"

# Set the iDRAC IP variable
IDRAC_IP="127.0.0.1"

function pause (){
  read -p "Press any key to continue..."
}

function get_status(){
	ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type fan
	ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type temperature
	ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type Voltage | grep Voltage
	ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type current
  pause
  menu
}

function set_fan_speed(){
  echo -n "Enter fans speed percent(0-100):"
  read percent
  hexpercent=`printf '%x\n' $percent`
  ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password raw 0x30 0x30 0x01 0x00
  ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password raw 0x30 0x30 0x02 0xff 0x$hexpercent
  pause
  menu
}

function get_fan_speed(){
  ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type fan | grep RPM
  pause
  menu
}

function get_temperature(){
  ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type temperature
  pause
  menu
}

function get_power(){
  ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type current | grep Watts
  pause
  menu
}

function menu ()
{
    cat << EOF
----------------------------------------
|*****************MENU*****************|
----------------------------------------
`echo -e "\033[35m 1)Get Server Status\033[0m"`
`echo -e "\033[35m 2)Set Fan Speed\033[0m"`
`echo -e "\033[35m 3)Get Fan Speed\033[0m"`
`echo -e "\033[35m 4)Get Server Temperature\033[0m"`
`echo -e "\033[35m 5)Get Server Power\033[0m"`
`echo -e "\033[35m 6)Back Menu\033[0m"`
`echo -e "\033[35m 7)EXIT\033[0m"`
EOF
read -p "Please enter the number:" num1
case $num1 in
    1)
      get_status
      ;;
    2)
      set_fan_speed
      ;;
    3)
      get_fan_speed
      ;;
    4)
      get_temperature
      ;;
    5)
      get_power
      ;;
    6)
      clear
      menu
      ;;
    7)
      exit 0
esac
}
menu
