#!/bin/bash
ready_filename="/hdfs_ready"
sudo -Hu hdfs timeout 10 hdfs dfs -touchz $ready_filename &>/dev/null && exit 0
exit 1

