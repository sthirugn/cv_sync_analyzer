# cv_sync_analyzer
This helps to analyze how the different content view capsule sync tasks are
performing in your Satellite6 environment.  To use it, follow these instructions:

## Getting Started
1. Download the rake script `generate_content_view_capsule_sync_metrics.rake` on your Satellite in the directory specified below:  
   Satellite 6.5 - `/opt/theforeman/tfm/root/usr/share/gems/gems/katello-3.10.0.46/lib/katello/tasks`  
   Satellite 6.4 - `/opt/theforeman/tfm/root/usr/share/gems/gems/katello-3.7.0.46/lib/katello/tasks`  
   Satellite 6.3 - `/opt/theforeman/tfm/root/usr/share/gems/gems/katello-3.4.5.87/lib/katello/tasks`  
2. Usage:
   Default run (last 7 days report)
   ```console
    # foreman-rake katello:generate_content_view_capsule_sync_metrics
   ```
   Specify number of days
   ```console
    # foreman-rake katello:generate_content_view_capsule_sync_metrics DAYS=21
   ```
3. Review `/tmp/content_view_sync_metrics.txt` for the created output. The output shows the runtime of capsule tasks breaking down the plan time and the execution time.  You will see the results sorted by the long-running tasks on the top.
   Sample output:
   ```console
   # foreman-rake katello:generate_content_view_sync_metrics DAYS=9
   # cat /tmp/content_view_sync_metrics.txt
   ForemanTaskId                            Start Time                   End Time             Duration(min)  Total planning(min)  Total execution(min)
   bc111aaf-a74a-4c55-81f5-54b3e423f49d   2019-04-18 18:51:14 UTC   2019-04-18 18:53:48 UTC        3              0.26              3
   6d835297-b157-49c5-b281-5e7f0d52478f   2019-04-18 18:51:30 UTC   2019-04-18 18:54:02 UTC        3              0.27              3
   ```
