require 'spec_helper'

RSpec.describe Enver do
  before do
    ENV['ENVER_TEST'] = 'OK'
  end

  it 'should load from ENV' do
    env = Enver.load do
      string :enver_test, 'ENVER_TEST'
    end

    expect(env.enver_test).to eq('OK')
  end
end
