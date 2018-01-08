require 'spec_helper'

describe Negapoji do
  it 'has a version number' do
    expect(Negapoji::VERSION).not_to be nil
  end

  describe '#pointing' do
    it 'return type of nemeric' do
      expect(Negapoji.pointing('このテストが成功することを祈っています。').is_a?(Numeric))
    end
  end
end
