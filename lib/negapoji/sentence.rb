module Sentence
  KAIGYO = /(\r\n|\r|\n|\f)/

  def remove_kaigyo(sentence)
    sentence_chomped = sentence.gsub(KAIGYO, '')
  end
end
