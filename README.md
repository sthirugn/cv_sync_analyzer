# cv_sync_analyzer
This helps to analyze how the different content view capsule sync tasks are
performing in your Satellite6 environment.  To use it, follow these instructions:

## Getting Started
1. Download the attached script `cv_sync_task_metrics.sh` from this case on your
Satellite.
2. Make the script executable.
  ```console
  # chmod +x cv_sync_task_metrics.sh
  ```
3. (optional) The script defaults to query last 7 days - If necessary, edit
   cv_sync_task_metrics.sh to update `number_of_days_to_query` variable
   accordingly.
4. Run the script
  ```console
  # ./cv_sync_task_metrics.sh
  ```
5.  Review `/foremantmp/data.txt` for the created output. The output shows the runtime of capsule tasks breaking down the plan time and the execution time.  You will see the results sorted by the long-running tasks on the top.
6. (optional) Remove /foremantmp directory if not needed anymore.
