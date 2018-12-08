#!/usr/bin/ruby
require 'set'

def put_worker_on_job(worker,job,working_steps,finished_steps)
  new_job = nil
  working_steps.each do |working_step|
    if job == nil || finished_steps.include?(job)
      new_job = working_step
      break
    end
  end
  if new_job != nil
    working_steps.reject!{| step | step == new_job}
    job = new_job
  end
  return job
end

def calc_job_times(worker,job,job_time,finished_steps)
  current_job = job
  if job != nil
    job_time[job] -= 1
    if job_time[job] == 0
      finished_steps << job
      current_job = nil
    end
  end
  return current_job
end

input_array = File.readlines('input.txt')

steps = Set.new([])

hash_map = {}
input_array.map do | line |
  required_step = line.split(' ')[1]
  step = line.split(' ')[7]
  steps << step
  steps << required_step
  if hash_map[step] == nil
    hash_map[step] = [required_step]
  else
    hash_map[step] << required_step
  end
end

finished_steps = []
inserted_steps = []
seconds = 0
workers = {1=>nil,2=>nil,3=>nil,4=>nil,5=>nil}
job_time = {}
steps.each do |step|
  job_time[step] = step.tr("A-Z", "1-9a-q").to_i(27) + 60
end

while finished_steps.size < steps.size
  workers = workers.map { |worker, job| [worker, calc_job_times(worker,job,job_time,finished_steps)] }.to_h
  working_steps = []
  steps.each do |step|
    if hash_map[step] == nil && job_time[step] > 0
      working_steps << step
    end
    if hash_map[step] != nil && (hash_map[step]&finished_steps).size == hash_map[step].size && job_time[step] > 0
      working_steps << step
    end
  end
  working_steps.reject!{ |job| workers.values.include? job }
  if !working_steps.empty?
    working_steps.sort!
  end
  workers = workers.map { |worker, job| [worker, put_worker_on_job(worker,job,working_steps,finished_steps)] }.to_h
  seconds += 1
end
puts "It takes #{seconds - 1} seconds"
