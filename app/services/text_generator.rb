class TextGenerator
  def generate_with_strings(seed, strings)
    return nil unless strings && !strings.empty?

  end

  def generate(seed)
    refresh_tree

    gen_internal(seed)
  end

  private

  DEPTH = 5

  BEFORE_FIRST = "\0"
  AFTER_LAST = "\1"

  def get_texts
    posts = SourceText.pluck(:text).map(&:downcase)

    # mans = File.read(Rails.root.join('man_ru.txt.small')).split('$$$###$$$')

    # pp ['Kalik', posts.map(&:length).reduce(:+)]
    # pp ['man', mans.map(&:length).reduce(:+)]

    all_posts = posts
    # all_posts = mans + posts
    all_posts.map(&:downcase)
  end

  def refresh_tree
    @root = Node.new

    get_texts.each do |post|
      post = BEFORE_FIRST + post + AFTER_LAST

      post.chars.each_cons(DEPTH) do |tok|
        v = @root
        tok.each { |t| v = v.add(t) }
      end
    end
  end

  def gen_internal(seed)
    ans = seed.empty? ? BEFORE_FIRST : seed

    loop do
      last = ans.last(DEPTH - 1).chars

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
      end

      char = v.get.first || @root.get.first

      break if char == AFTER_LAST

      ans += char
    end

    ans.gsub(BEFORE_FIRST, '')
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
