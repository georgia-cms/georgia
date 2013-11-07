require 'spec_helper'

describe Georgia::MenuAncestryParser do

  SERIALIZED_STRING = "link[149]=null&link[150]=149&link[151]=149&link[152]=149&link[1]=null&link[153]=1&link[10]=1&link[26]=1&link[27]=1&link[28]=1&link[29]=1&link[136]=1&link[5]=null&link[55]=5&link[133]=55&link[58]=5&link[90]=58&link[92]=58&link[91]=58&link[113]=5&link[130]=113&link[131]=113&link[132]=113&link[54]=5&link[83]=54&link[82]=54&link[81]=54&link[80]=54&link[118]=5&link[140]=118&link[139]=118&link[126]=118&link[57]=5&link[85]=57&link[87]=57&link[88]=57&link[89]=57&link[86]=57&link[116]=5&link[145]=116&link[117]=5&link[135]=117&link[4]=null&link[17]=4&link[18]=17&link[19]=17&link[25]=4&link[111]=25&link[35]=25&link[142]=4&link[154]=142&link[143]=142&link[141]=142&link[138]=4&link[155]=138&link[146]=138&link[147]=138&link[30]=4&link[32]=30&link[33]=30&link[31]=30&link[122]=4&link[128]=122&link[129]=122&link[164]=null"

  describe '.to_hash' do

    before :each do
      @parser = Georgia::MenuAncestryParser.new(SERIALIZED_STRING)
    end

    it 'returns a consumable hash with position and parent_id' do
      @parser.should respond_to :to_hash
      @parser.to_hash.should be_a_kind_of Hash
      @parser.to_hash.first.should == {"149" => {position: 1, parent_id: nil}}
      @parser.to_hash.should include({"142" => {position: 50, parent_id: 4}})
    end

  end

end