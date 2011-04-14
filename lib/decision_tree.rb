class DecisionTree

  def initialize params
    candidates, factors = params[:candidates], params[:factors]

    factors_by_preference = {}

    candidates.each do |candidate|
      factors.each do |factor|
        value = candidate.send(factor) || next
        factors_by_preference[factor] ||= {}
        factors_by_preference[factor][value] ||= 0
        factors_by_preference[factor][value] += 1
      end
    end

    @trie = {}
    @factors = []

    factors_by_preference.sort {|a, b| sum_values_of(b[1]) <=> sum_values_of(a[1])}.each do |factor, values|
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

  private

  def sum_values_of hash
    hash.values.inject {|sum, x| sum += x }
  end
end