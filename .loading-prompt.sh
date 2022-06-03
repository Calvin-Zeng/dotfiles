#!/bin/bash
# https://www.gilesorr.com/bashprompt/prompts/load.html

CYAN="$(tput bold ; tput setaf 6)"
NOCOLOUR="$(tput sgr0)"
MAXMEMSIZE="$(free -h|awk '/^Mem:/{print $2}' | sed -e "s/Gi//g" -e "s/G//g")"

load_out() {
  echo -n "$(uptime | sed -e "s/.*load average: \(.*\...\), \(.*\...\), \(.*\...\).*/\1/" -e "s/ //g")"
}

load_out_mem() {
  echo -n "$(free -h|awk '/^Mem:/{print $7}' | sed -e "s/Gi//g" -e "s/G//g")"
}

load_color() {
  gray=0
  red=1
  green=2
  yellow=3
  blue=4
  magenta=5
  cyan=6
  white=7

  # Colour progression is important ...
  #   bold gray -> bold green -> bold yellow -> bold red ->
  #   black on red -> bold white on red
  #
  # Then we have to choose the values at which the colours switch, with
  # anything past yellow being pretty important.

  tmp=$(echo $(load_out)*100 | bc)
  let load100=${tmp%.*}

  if [ ${load100} -lt 70 ]
  then
    # tput bold ;
    tput setb 5 setaf ${gray}
  elif [ ${load100} -ge 70 ] && [ ${load100} -lt 120 ]
  then
    tput bold ; tput setaf ${green}
  elif [ ${load100} -ge 120 ] && [ ${load100} -lt 200 ]
  then
    tput bold ; tput setaf ${yellow}
  elif [ ${load100} -ge 200 ] && [ ${load100} -lt 300 ]
  then
    tput bold ; tput setaf ${red}
  elif [ ${load100} -ge 300 ] && [ ${load100} -lt 500 ]
  then
    tput setaf ${gray} ; tput setab ${red}
  else
    tput bold ; tput setaf ${white} ; tput setab ${red}
  fi
}

load_color_mem() {
  gray=0
  red=1
  green=2
  yellow=3
  blue=4
  magenta=5
  cyan=6
  white=7

  # Colour progression is important ...
  #   bold gray -> bold green -> bold yellow -> bold red ->
  #   black on red -> bold white on red
  #
  # Then we have to choose the values at which the colours switch, with
  # anything past yellow being pretty important.

  tmp=$(echo \(${MAXMEMSIZE}-$(load_out_mem)\) / ${MAXMEMSIZE}*100 | bc -l)
  let load100=${tmp%.*}

  if [ ${load100} -lt 20 ]
  then
    # tput bold ;
    tput setb 5 setaf ${gray}
  elif [ ${load100} -ge 20 ] && [ ${load100} -lt 40 ]
  then
    tput bold ; tput setaf ${green}
  elif [ ${load100} -ge 40 ] && [ ${load100} -lt 60 ]
  then
    tput bold ; tput setaf ${yellow}
  elif [ ${load100} -ge 60 ] && [ ${load100} -lt 80 ]
  then
    tput bold ; tput setaf ${red}
  elif [ ${load100} -ge 80 ] && [ ${load100} -lt 100 ]
  then
    tput setaf ${gray} ; tput setab ${red}
  else
    tput bold ; tput setaf ${white} ; tput setab ${red}
  fi
}
