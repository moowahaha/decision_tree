class DecisionTree

  def initialize params
    candidates, factors = params[:candidates], params[:factors]

    factors_by_preference = {}

    candidates.each do |candidate|
      factors.each do |factor|
        value = candidate.send(factor) || next
        factors_by_preference[factor] ||= {}
        factors_by_preference[factor][value] ||= true
      end
    end

    @trie = {}
    @factors = []

    factors_by_preference.sort {|a, b| b[1].length <=> a[1].length}.each do |factor, values|
      @factors << factor
      @trie[factor] = {}

      values.keys.each do |value|
        @trie[factor][value] = []

        candidates.each do |candidate|
          @trie[factor][value] << candidate if candidate.send(factor) == value
        end
      end
    end
  end

  def best_for matcher
    short_list = []

    @factors.each do |factor|
      value = matcher.send(factor)
      matches = @trie[factor][value] || break
      short_list = short_list.empty? ? matches : matches & short_list
    end

    short_list.first
  end
end