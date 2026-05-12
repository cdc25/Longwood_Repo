#!/bin/bash
# summarize-slurm-jobs.sh

echo "Grouping SLURM jobs by name and exit code..."
echo ""

sacct --format=jobname,exitcode,user --noheader --parsable2 | \
  awk -F'|' '
  {
    key = $1 "|" $2
    count[key]++
    users[key][$3] = 1
  }
  END {
    for (k in count) {
      split(k, parts, "|")
      jobname = parts[1]
      exitcode = parts[2]
      user_list = ""
      for (u in users[k]) {
        if (user_list != "") user_list = user_list ", "
        user_list = user_list u
      }
      printf "%-30s %-8s %3d jobs  Users: %s\n", jobname, exitcode, count[k], user_list
    }
  }' | sort
