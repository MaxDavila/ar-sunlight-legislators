require_relative '../../db/config'


class Legislator < ActiveRecord::Base
  def self.reps_from_state(state)

  end

  def self.senators_from_state(state)
  end

  def self.reps_in_party(party)
  end

  def self.senators_in_party(party)
  end

  def legislator_attributes(legislator)
  end

  def legislator_active?(legislator)
  end
end
