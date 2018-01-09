require 'singleton'
require 'natto'

module Negapoji
  class Dictionary
    include Singleton

    DIC_PATH = __dir__

    def initialize
      @mecab = Natto::MeCab.new
      @pn_wago_verbs_and_adjectives = create_pn_wago_verbs_and_adjectives
      @pn_wago_nouns = create_pn_wago_nouns
    end

    def create_pn_wago_verbs_and_adjectives
      point = []
      word = []
      File.open(DIC_PATH + '/../../dic/wago.121808.pn', 'r:utf-8') do |f|
        while line = f.gets
          content = line.split(',')
          point.push(content[0])
          word.push(content[2].chomp)
        end
      end
      { word: word, point: point }
    end

    def create_pn_wago_nouns
      point = []
      word = []
      File.open(DIC_PATH + '/../../dic/pn.csv.m3.120408.trim', 'r:utf-8') do |f|
        while line = f.gets
          content = line.split(',')
          word.push(content[0])
          point.push(content[1])
        end
      end
      @pn_wago_nouns = { word: word, point: point }
    end

    attr_reader :pn_wago_verbs_and_adjectives
    attr_reader :pn_wago_nouns
  end
end
