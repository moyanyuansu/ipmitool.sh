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
 	ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password power status
  pause
  menu
}

function set_man_fan_speed(){
  echo -n "Enter fans speed percent(0-100):"
  read percent
  hexpercent=`printf '%x\n' $percent`
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password raw 0x30 0x30 0x01 0x00  > /dev/null 2>&1 &
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password raw 0x30 0x30 0x02 0xff 0x$hexpercent  > /dev/null 2>&1 &
  echo "Fan speed set to manually mode, speed is $percent%"
  pause
  menu
}

function set_auto_fan_speed(){
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password raw 0x30 0x30 0x01 0x01  > /dev/null 2>&1 &
  echo "Fan speed set to automatic mode"
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

function get_power_consumption(){
  ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password sdr type current | grep Watts
  pause
  menu
}

function get_power_status(){
  ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password power status
  pause
  menu
}

function set_power_off(){
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password power off > /dev/null 2>&1 &
  echo "The power of server is turnning off"
  pause
  menu
}

function set_power_off_soft(){
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password power soft > /dev/null 2>&1 &
  echo "The power of server is turnning off softly"
  pause
  menu
}

function set_power_on(){
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password power on > /dev/null 2>&1 &
  echo "The power of server is turnning on"
  pause
  menu
}

function set_power_reset(){
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password power reset > /dev/null 2>&1 &
  echo "The power of server is resetting"
  pause
  menu
}

function set_power_cycle(){
  nohup ipmitool -I lanplus -H $IDRAC_IP -U $username -P $password power cycle > /dev/null 2>&1 &
  echo "The power of server will be turnning off and then on after 1s"
  pause
  menu
}

function fan_submenu(){
  cat << EOF
----------------------------------------
|***************SUBMENU****************|
----------------------------------------
`echo -e "\033[35m 1)Auto Fan Speed\033[0m"`
`echo -e "\033[35m 2)Manually Fan Speed\033[0m"`
`echo -e "\033[35m 3)Back Menu\033[0m"`
`echo -e "\033[35m 4)EXIT\033[0m"`
EOF
read -p "Please enter the number:" num2
case $num2 in
    1)
      set_auto_fan_speed
      ;;
    2)
      set_man_fan_speed
      ;;
    3)
      clear
      menu
      ;;
    4)
      exit 0
esac
}

function power_submenu(){
  cat << EOF
----------------------------------------
|***************SUBMENU****************|
----------------------------------------
`echo -e "\033[35m 1)Power Off\033[0m"`
`echo -e "\033[35m 2)Power Off Soft\033[0m"`
`echo -e "\033[35m 3)Power On\033[0m"`
`echo -e "\033[35m 4)Power Reset\033[0m"`
`echo -e "\033[35m 5)Power Cycle\033[0m"`
`echo -e "\033[35m 6)Back Menu\033[0m"`
`echo -e "\033[35m 7)EXIT\033[0m"`
EOF
read -p "Please enter the number:" num3
case $num3 in
    1)
      set_power_off
      ;;
    2)
      set_power_off_soft
      ;;
    3)
      set_power_on
      ;;
    4)
      set_power_reset
      ;;
    5)
      set_power_cycle
      ;;
    6)
      clear
      menu
      ;;
    7)
      exit 0
esac
}

function menu (){
    cat << EOF
----------------------------------------
|*****************MENU*****************|
----------------------------------------
`echo -e "\033[35m 1)Get Server Status\033[0m"`
`echo -e "\033[35m 2)Set Fan Speed\033[0m"`
`echo -e "\033[35m 3)Get Fan Speed\033[0m"`
`echo -e "\033[35m 4)Get Server Temperature\033[0m"`
`echo -e "\033[35m 5)Get Server Power Consumption\033[0m"`
`echo -e "\033[35m 6)Set Server Power Status\033[0m"`
`echo -e "\033[35m 7)Get Server Power Status\033[0m"`
`echo -e "\033[35m 8)Back Menu\033[0m"`
`echo -e "\033[35m 9)EXIT\033[0m"`
EOF
read -p "Please enter the number:" num1
case $num1 in
    1)
      get_status
      ;;
    2)
      fan_submenu
      ;;
    3)
      get_fan_speed
      ;;
    4)
      get_temperature
      ;;
    5)
      get_power_consumption
      ;;
    6)
      power_submenu
      ;;
    7)
      get_power_status
      ;;
    8)
      clear
      menu
      ;;
    9)
      exit 0
esac
}
menu
