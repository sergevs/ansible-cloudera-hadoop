#!/bin/bash

log_filename="{{ log_folder }}/hdfs/hdfs-ready.log"
ready_filename="/hdfs_ready"

while true; do
  echo "`date -u`: check hdfs" >>$log_filename
  sudo -Hu hdfs hdfs dfs -touchz $ready_filename >>$log_filename 2>&1 && break
  echo >>$log_filename
  sleep 10
done
sudo -Hu hdfs hdfs dfs -rm $ready_filename >>$log_filename 2>&1
echo >>$log_filename

exit 0

