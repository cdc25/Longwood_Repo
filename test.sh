#!/bin/bash
# summarize-slurm-jobs.sh

sacct --format=jobname,exitcode,user --noheader --parsable2 | \
  sort | uniq -c | \
  awk -F'|' '{print $1, $2, $3}' | \
  column -t -N "COUNT,JOBNAME,EXITCODE,USER"
