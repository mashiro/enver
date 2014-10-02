require 'spec_helper'
require 'enver/core_ext/env'

RSpec.describe ENV do
  it { expect(ENV).to be_respond_to :load }
end
