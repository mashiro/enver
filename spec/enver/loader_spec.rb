# coding: utf-8
require 'spec_helper'

RSpec.describe Enver::Loader do
  let(:env) do
    {
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
    }
  end
  let(:loader) { Enver::Loader.new(env) }

  describe '#fetch' do
    it { expect{loader.send(:fetch, 'NOTHING')}.to raise_error }
    it { expect(loader.send(:fetch, 'NOTHING', default: 123)).to eq(123) }
  end

  describe '#string' do
    it { expect(loader.string('v', 'STRING1')).to eq('') }
    it { expect(loader.string('v', 'STRING2')).to eq('test') }
  end

  describe '#integer' do
    it { expect{loader.integer('v', 'INTEGER1')}.to raise_error }
    it { expect(loader.integer('v', 'INTEGER2')).to eq(1) }
    it { expect{loader.integer('v', 'INTEGER3')}.to raise_error }
    it { expect{loader.integer('v', 'INTEGER4')}.to raise_error }
  end

  describe '#boolean' do
    it { expect(loader.boolean('v', 'BOOLEAN1')).to eq(false) }
    it { expect(loader.boolean('v', 'BOOLEAN2')).to eq(true) }
    it { expect(loader.boolean('v', 'BOOLEAN3')).to eq(false) }
    it { expect(loader.boolean('v', 'BOOLEAN4')).to eq(true) }
    it { expect(loader.boolean('v', 'BOOLEAN5')).to eq(false) }
    it { expect(loader.boolean('v', 'BOOLEAN6')).to eq(true) }
    it { expect(loader.boolean('v', 'BOOLEAN7')).to eq(false) }
    it { expect(loader.boolean('v', 'BOOLEAN8')).to eq(true) }
    it { expect(loader.boolean('v', 'BOOLEAN9')).to eq(false) }
    it { expect(loader.boolean('v', 'BOOLEAN10')).to eq(false) }
    it { expect(loader.boolean('v', 'BOOLEAN10', true_values: %w(はい))).to eq(true) }
  end

  describe '#array' do
    it { expect(loader.array('v', 'ARRAY1')).to eq(['foo', 'bar', 'buzz']) }
    it { expect(loader.array('v', 'ARRAY2', pattern: ':')).to eq(['foo', 'bar', 'buzz']) }
    it { expect(loader.array('v', 'ARRAY1', limit: 2)).to eq(['foo', 'bar,buzz']) }
  end
end
