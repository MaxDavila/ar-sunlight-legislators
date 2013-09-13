require_relative '../../db/config'


class Legislator < ActiveRecord::Base
  def self.get_reps_from(state)
    Legislator.where("state = ? AND title = ?", state, 'Rep')
  end

  def self.get_senators_from(state)
    Legislator.where("state = ? AND title = ?", state, 'Sen')
  end

  def self.get_reps_who_are(party)
    Legislator.where("party = ? AND title = ?", party, 'Rep')
  end

  def self.get_senators_who_are(party)
    Legislator.where("party = ? AND title = ?", party, 'Sen')
  end
  
  def self.get_all_reps
    Legislator.where("title = 'Rep'")
  end

  def self.get_all_senators
    Legislator.where("title = 'Sen'")
  end

  def self.get_all_inactive
    Legislator.where(in_office: 'f')
  end

  def self.get_all_by(gender)
    Legislator.find_all_by_gender(gender)
  end

  def self.get_state_info
    stateinfo = Legislator.where("in_office = 't' AND title = 'Rep'").group(:state).order("count(legislators.id) DESC").count
    stateinfo.each {|key, value| puts "#{key}: 2 Senators, #{value} Representative(s)"}
  end
end
