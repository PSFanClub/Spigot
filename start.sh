#!/bin/bash

cd /home/

echo "Prepare config files from environment variables"
printenv | while read line
do

  # Seperate variable name and value
  IFS="=" read -r var val <<< "$line"

  # Check if we the variable is prefixed with "MC_"
  if [[ $var != MC_* ]]
  then
    continue
  fi

  # Replace all {$var} placeholders in spigot.yml, bukkit.yml,
  # paper.yml, server.properties and /plugins/*/config.yml
  echo "Setting variable \"$var\" with value: \"$val\" in all config files"

  sed -i "s/{$var}/$val/g" bukkit.yml
  sed -i "s/{$var}/$val/g" spigot.yml
  sed -i "s/{$var}/$val/g" paper.yml
  sed -i "s/{$var}/$val/g" server.properties

  for folder in plugins/*
  do
    if [ -d "${folder}" ]
    then
      sed -i "s/{$var}/$val/g" $folder/config.yml
    fi
  done

done

echo "Fire up Java VM and transfer PID 1 to the new process"
# (Enables graceful remote shutdown)

exec java -Xms$MC_MIN_RAM -Xmx$MC_MAX_RAM -d64 -server -XX:+PrintGCTimeStamps -Dfile.encoding=UTF-8 -Dcom.mojang.eula.agree=true -jar server.jar
