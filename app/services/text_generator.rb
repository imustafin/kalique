class TextGenerator
  def generate_with_strings(seed, strings)
    return nil unless strings && !strings.empty?

    prefix = seed || ''

    markov = MarkyMarkov::TemporaryDictionary.new(2)
    strings.each do |t|
      markov.parse_string(pack_string(t.to_s))
    end

    prefix + ' ' + unpack_string(markov.generate_10_sentences)
  end

  def generate(seed)
    generate_with_strings(seed, SourceText.pluck(:text))
  end


  PACK_MAP = {
    "\n" => "\1"
  }
  def pack_string(s)
    ans = s
    PACK_MAP.each do |k, v|
      ans = ans.gsub(k, v)
    end

    ans
  end

  def unpack_string(s)
    ans = s

    PACK_MAP.each do |k, v|
      ans = ans.gsub(v, k)
    end

    ans
  end
end
