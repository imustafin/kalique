class TextGenerator
  def generate(seed)
    prefix = seed || ''

    texts = SourceText.pluck(:text)

    markov = MarkyMarkov::TemporaryDictionary.new(2)
    texts.each do |t|
      markov.parse_string(pack_string(t))
    end

    prefix + ' ' + unpack_string(markov.generate_10_sentences)
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
