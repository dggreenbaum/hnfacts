#!/bin/bash

DATE_FORMAT="+%Y-%m-%d %H:%M:%S"

CONFIG_FILE="/etc/hnfacts.conf"
LOG_DIR="/var/log/hnfacts"

FACT_NAMES=()

read_fact_names() {
  while read p; do
    FACT_NAMES=(${FACT_NAMES[@]} $p)
  done < $CONFIG_FILE
}

set_facts() {
  while IFS='.' read -ra FACT_VALUES; do
  	n=0
    for i in "${FACT_VALUES[@]}"; do
      echo "set: " `date "$DATE_FORMAT"`"	fact ${FACT_NAMES[$n]}:	$i" >> "$LOG_DIR/hnfacts.log"
      eval export FACTER_${FACT_NAMES[$n]}=$i
      n=$((n+1))
    done
  done <<< `hostname`
}


if [ ! -d "$LOG_DIR" ]; then
mkdir -p $LOG_DIR
fi

if [ ! -r "$CONFIG_FILE" ]; then
echo "Cannot find or read the configuration file. Please create or check the permissions of the following file: \"$CONFIG_FILE\"."
exit 1
fi

echo "Starting hnfacts ..."
echo "start: " `date "$DATE_FORMAT"` >> "$LOG_DIR/hnfacts.log"
read_fact_names
set_facts
