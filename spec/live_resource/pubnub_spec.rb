require 'spec_helper'

describe LiveResource::Pubnub do
  it 'should have a version number' do
    LiveResource::Pubnub::VERSION.should_not be_nil
  end
end
