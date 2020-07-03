class TextGenerator
  def generate(seed)
    prefix = seed || ''

    prefix + ' ' + 5.times.map { WORDS.sample(5) }.join(' ') + '.'
  end

  WORDS = [
    'hello',
    'this',
    'is',
    'generated',
    ':)',
    "\u{1f34f}",
    "\u{1f34e}"
  ]
end
