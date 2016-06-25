# -*- coding:utf-8 -*-

require 'natto'
require File.expand_path(File.dirname(__FILE__)) + '/dictionary.rb'
require File.expand_path(File.dirname(__FILE__)) + '/sentence.rb'

module Negapoji

  class Feeling

    include Sentence

    def initialize
      @mecab = Natto::MeCab.new
      @pn_wago_verbs_and_adjectives = self.set_pn_wago_verbs_and_adjectives
      @pn_wago_nouns = self.set_pn_wago_nouns
      @hinshi_collected = ['名詞', '形容詞', '副詞', '動詞']
    end

    def pointing(sentence)
      sentence_chomped = self.remove_kaigyo(sentence)
      @point = self.simple_voting(self.inui_okazaki(sentence_chomped))
    end

    def inui_okazaki(sentence)
      word_point_list = Array.new
      @mecab.parse(sentence) do |sentence_parsed|
        feature = sentence_parsed.feature.split(',')
        if @hinshi_collected.include?(feature[0])
          pn = feature[0] == "名詞" ? @pn_wago_nouns : @pn_wago_verbs_and_adjectives
          index = pn[:word].index(feature[6])
          unless index.nil? then
            word_point_list.push({word: feature[6], point: pn[:point][index]})
          end
        end
      end
      return word_point_list
    end

    protected

      def set_pn_wago_verbs_and_adjectives
        dictionary = Negapoji::Dictionary.instance
        dictionary.pn_wago_verbs_and_adjectives
      end

      def set_pn_wago_nouns
        dictionary = Negapoji::Dictionary.instance
        dictionary.pn_wago_nouns
      end

      def simple_voting(word_point_list)
        the_day_point = 0
        word_point_list.each do |word_point|
          the_day_point += word_point[:point].to_f
        end
        @result = the_day_point == 0 ? the_day_point : the_day_point/ word_point_list.count.to_i
      end
  end
end
