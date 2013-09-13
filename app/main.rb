require_relative '../app/models/legislator'
require_relative '../app/models/representative'
require_relative '../app/models/senator'

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
  Legislator.get_state_info
end

#print_state_legislator_counts
p Senator.all
