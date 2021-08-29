#!/bin/bash

flavor='dev'

run_fastlane() {
  bundle exec fastlane $1
}

select_flavor(){
  echo "Select the flavor:"
  echo "1: dev"
  echo "2: prod"
  read value

  if [ $value -eq 1 ]
  then
    flavor="dev"
  elif [ $value -eq 2 ]
  then
    flavor="prod"
  fi
}

deploy(){
  select_flavor
  cd ios
  run_fastlane $flavor
  cd ../android
  run_fastlane $flavor
}

deploy


