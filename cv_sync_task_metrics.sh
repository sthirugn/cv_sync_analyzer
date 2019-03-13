#!/bin/bash
mkdir -p /foremantmp
chown foreman:foreman /foremantmp

foreman-rake console << EOF

# By default query last 7 days, change this number as desired without stressing Satellite.
number_of_days_to_query = 7.days

output_file = '/foremantmp/data.txt'
f = File.new(output_file, 'w')

f.write "ForemanTaskId                            Start Time                   End Time             Duration(min)  Total planning(min)  Total execution(min)\n"

# Query only Actions::Katello::CapsuleContent::Sync tasks with state = stopped and started_at > number_of_days_to_query
tasks = ForemanTasks::Task.where(:label => "Actions::Katello::CapsuleContent::Sync").where(:state => 'stopped').where("result !=?", 'error').where("started_at > ?", DateTime.now - number_of_days_to_query); 0

# Sort by long running tasks first
tasks = tasks.sort_by {|task| -(task.ended_at - task.started_at)}; 0

tasks.each do |task|
  #puts "foreman_task_id is #{task.id}"
  execplan = task.execution_plan
  plan_values = execplan.steps.values

  plansteps = plan_values.select { |plan| plan.class == Dynflow::ExecutionPlan::Steps::PlanStep}
  runsteps = plan_values.select { |plan| plan.class == Dynflow::ExecutionPlan::Steps::RunStep}

  if plansteps.count != 0
    started_at = plansteps.map(&:started_at).min
    ended_at = plansteps.map(&:ended_at).max
    total_planning_time = ((ended_at - started_at)/60).round(2)
  end; 0

  if runsteps.count != 0
    started_at = runsteps.map(&:started_at).min
    ended_at = runsteps.map(&:ended_at).max
    total_running_time = ((ended_at - started_at)/60).ceil
  end; 0
  
  f.write "#{task.id}   #{task.started_at}   #{task.ended_at}        #{((task.ended_at - task.started_at)/60).ceil}              #{total_planning_time}              #{total_running_time}\n"
end.count
EOF