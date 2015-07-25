# See http://www.benjaminoakes.com/2014/01/24/count_by-in-ruby/
module Enumerable
  def count_by(&block)
    group_by(&block).map { |criteria, group| [criteria, group.count] }.sort_by(&:last).to_h
  end
end

