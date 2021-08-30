red='\e[31m'
green='\e[32m'
yellow='\e[33m'
white='\e[97m'
reset='\e[0m'
bold='\e[1m'
greenBg='\e[42m'
yellowBg='\e[43m'
magentaBg='\e[45m'

you_re_here="You're here: "

flavor='dev'

run_fastlane() {
  bundle exec fastlane $1
}

select_flavor() {
  echo "Welcome to the show\n"
  echo -e "${red}${bold}[1]${reset}${green}: [dev] Development${reset}"
  echo "${yellow}${bold}[2]${reset}${green}: [prod] Production${reset}"
  printf "${green}\nPlease select your flavor, default is ${magentaBg}${white}[dev]${reset} (Press ${white}${yellowBg}enter${reset} to use the default): ${reset}"
  read value

  if [ $value -eq 2 ]
  then
    flavor="prod"
  fi
}

deploy() {
  select_flavor
  cd ios
  echo "${you_re_here}${white}${bold}${greenBg}$(pwd)${reset}"
  run_fastlane $flavor
  cd ../android
  echo "${you_re_here}${white}${bold}${greenBg}$(pwd)${reset}"
  run_fastlane $flavor
}

deploy


