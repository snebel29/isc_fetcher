require 'spec_helper'

#TODO Add vcr tests

describe ISC::Attack do

  describe '.clean_ip' do
    it 'returns a valid ip address' do
      expect(ISC::Attack.new({}).clean_ip('069.243.226.007')).to eq('69.243.226.7')
    end
  end

end

