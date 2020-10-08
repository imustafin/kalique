class TextGenerator
  def generate_with_strings(seed, strings)
    return nil unless strings && !strings.empty?

  end

  def generate(seed)
    refresh_tree

    gen_internal(seed)
  end

  private

  DEPTH = 10

  def refresh_tree
    posts = SourceText.pluck(:text)

    @root = Node.new

    posts.each do |post|
      post.chars.each_cons(DEPTH) do |tok|
        v = @root
        tok.each { |t| v = v.add(t) }
      end
    end
  end

  def gen_internal(seed)
    ans = seed || @root.get.first

    100.times do
      last = ans.last(DEPTH - 1).chars

      pp last

      v = @root
      path = []
      until last.empty?
        char = last.shift
        v = v.step(char)

        unless v
          v = @root.step(char)
          path = []
        end

        path << char

        pp path
      end

      ans += v.get.first || @root.get.first
    end

    ans
  end

  class Node
    def initialize
      @children = Hash.new { [0, Node.new] } # char => [count, Node]
    end

    def add(char)
      raise "Can add only one char (#{char} given)" if char.length != 1

      child = @children[char]
      child[0] += 1

      @children[char] = child

      child.last
    end

    def get
      sum_counts = @children.values.map(&:first).sum

      char, (_, node) = @children.max_by { |_, (count, _)| rand ** (1. / (count.to_f / sum_counts)) }

      [char, node]
    end

    def step(char)
      @children[char].last
    end
  end
end
