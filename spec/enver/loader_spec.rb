# coding: utf-8
require 'spec_helper'

RSpec.describe Enver::Loader do
  let(:env) do
    {
      'VALUE' => 'enver',
      'STRING1' => '',
      'STRING2' => 'test',
      'INTEGER1' => '',
      'INTEGER2' => '1',
      'INTEGER3' => '1.0',
      'INTEGER4' => '123test',
      'BOOLEAN1' => '',
      'BOOLEAN2' => '1',
      'BOOLEAN3' => '0',
      'BOOLEAN4' => 't',
      'BOOLEAN5' => 'f',
      'BOOLEAN6' => 'true',
      'BOOLEAN7' => 'false',
      'BOOLEAN8' => 'yes',
      'BOOLEAN9' => 'no',
      'BOOLEAN10' => 'はい',
      'ARRAY1' => 'foo,bar,buzz',
      'ARRAY2' => 'foo:bar:buzz',
      'MY_VALUE1' => 'myvalue1',
      'MY_VALUE2' => 'myvalue2',
      'MY_SUPER_VALUE1' => 'mysupervalue1',
      'MY_SUPER_VALUE2' => 'mysupervalue2',
    }
  end
  let(:loader) { Enver::Loader.new(env) }

  describe '#fetch' do
    it { expect{loader.send(:fetch, 'NOTHING')}.to raise_error }
    it { expect(loader.send(:fetch, 'NOTHING', default: 123)).to eq(123) }
  end

  describe '#value' do
    it { expect(loader.value(:v, 'VALUE')).to eq('enver') }
    it { expect(loader.value(:value)).to eq('enver') }
  end

  describe '#string' do
    it { expect(loader.string(:string1)).to eq('') }
    it { expect(loader.string(:string2)).to eq('test') }
  end

  describe '#integer' do
    it { expect{loader.integer(:integer1)}.to raise_error }
    it { expect(loader.integer(:integer2)).to eq(1) }
    it { expect{loader.integer(:integer3)}.to raise_error }
    it { expect{loader.integer(:integer4)}.to raise_error }
  end

  describe '#boolean' do
    it { expect(loader.boolean(:boolean1)).to eq(false) }
    it { expect(loader.boolean(:boolean2)).to eq(true) }
    it { expect(loader.boolean(:boolean3)).to eq(false) }
    it { expect(loader.boolean(:boolean4)).to eq(true) }
    it { expect(loader.boolean(:boolean5)).to eq(false) }
    it { expect(loader.boolean(:boolean6)).to eq(true) }
    it { expect(loader.boolean(:boolean7)).to eq(false) }
    it { expect(loader.boolean(:boolean8)).to eq(true) }
    it { expect(loader.boolean(:boolean9)).to eq(false) }
    it { expect(loader.boolean(:boolean10)).to eq(false) }
    it { expect(loader.boolean(:boolean10, true_values: %w(はい))).to eq(true) }
  end

  describe '#array' do
    it { expect(loader.array(:array1)).to eq(['foo', 'bar', 'buzz']) }
    it { expect(loader.array(:array2, pattern: ':')).to eq(['foo', 'bar', 'buzz']) }
    it { expect(loader.array(:array1, limit: 2)).to eq(['foo', 'bar,buzz']) }
  end

  describe '#partial' do
    it do
      loader.partial :my do
        string :value1
        string :value2
        partial :super do
          string :value1
          string :value2
        end
        partial :s2, 'SUPER_' do
          string :value1
          string :value2
        end
      end
      env = loader.attributes
      expect(env.my.value1).to eq('myvalue1')
      expect(env.my.value2).to eq('myvalue2')
      expect(env.my.super.value1).to eq('mysupervalue1')
      expect(env.my.super.value2).to eq('mysupervalue2')
      expect(env.my.s2.value1).to eq('mysupervalue1')
      expect(env.my.s2.value2).to eq('mysupervalue2')
    end
  end
end
