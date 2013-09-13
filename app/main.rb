require_relative '../app/models/legislator'

def print_legislators_from(state)
  reps = Legislator.get_reps_from(state)
  sens = Legislator.get_senators_from(state)
  puts "Senators:"
  sens.sort_by(&:lastname).each do |senator|
    puts "#{senator.firstname} #{senator.lastname} (#{senator.party})"
  end
  puts "Representatives:"
  reps.sort_by(&:lastname).each do |rep|
     puts "#{rep.firstname} #{rep.lastname} (#{rep.party})"
  end   
end

def print_legislator_count
  puts "Representatives: #{Legislator.get_all_reps.count}"
  puts "Senators: #{Legislator.get_all_senators.count}"
end

def print_percentages_for(gender)
   formated_gender = ""
   gender == 'F' ? formated_gender = "Female" : formated_gender = "Male"
   total_count = Legislator.get_all_reps.count
   gender_count = Legislator.get_all_reps.select {|rep| rep.gender == gender }.count 
  
   puts "#{formated_gender} representatives: #{gender_count} (#{((gender_count.to_f / total_count) * 100).to_i}%) "

   total_count = Legislator.get_all_senators.count
   gender_count = Legislator.get_all_senators.select { |senator| senator.gender == gender }.count
  puts "#{formated_gender} senators: #{gender_count} (#{((gender_count.to_f / total_count) * 100).to_i}%) "

end

def print_count_after_deleting_inactive
  Legislator.get_all_inactive.each {|legislator| legislator.destroy }
  print_legislator_count
end


#print_legislators_from('CA')

#print_count_after_deleting_inactive
# print_percentages_for('M')
def print_state_legislator_counts
 state_names = Legislator.all.map {|l| l.state }.uniq.sort

 rep_count_by_state = state_names.map do |state|
  state = Legislator.get_reps_from(state).count
 end

 sen_count_by_state = state_names.map do |state|
  state = Legislator.get_senators_from(state).count
 end
zipped_state_counts = state_names.zip(sen_count_by_state, rep_count_by_state)

zipped_state_counts = zipped_state_counts.map do |state|
  state = ["#{state[0]}: #{state[1]} Senators, #{state[2]} Representatives", state[2]]
  end

zipped_state_counts = zipped_state_counts.sort_by { |state| state[1]}.reverse
zipped_state_counts.each {|state| puts state[0]}
end


