require "spec_helper"

include LiveResource::Pubnub

describe PubnubProtocol do

  it 'should include the Protocol module' do
    expect(PubnubProtocol).to include(LiveResource::Protocol)
  end

  let(:pubnub_protocol) { PubnubProtocol.new(pubnub) }

  let(:pubnub) { double('Pubnub', publish: nil) }

  describe "#publish_message" do
    subject { pubnub_protocol.publish_message(resource_id, message_type, params) }

    let(:resource_id) { :some_resource }
    let(:message_type) { 'resource:reset' }
    let(:params) {}
    let(:channel) { 'hashed-channel-ID' }

    before do
      pubnub_protocol.stub(channel_for: channel)
    end

    it 'should get the channel ID for the resource' do
      pubnub_protocol.should_receive(:channel_for).with(resource_id)
      subject
    end

    it 'should publish a message to pubnub' do
      pubnub.should_receive(:publish)
      subject
    end

    describe 'the message' do
      subject { pubnub_message }

      let(:pubnub_message) { @pubnub_argument[:message] }
      let(:pubnub_channel) { @pubnub_argument[:channel] }
      let(:pubnub_callback) { @pubnub_argument[:callback] }

      before do
        _arg = nil
        pubnub.stub(:publish) { |arg| _arg = arg }
        pubnub_protocol.publish_message(resource_id, message_type, params)
        @pubnub_argument = _arg
      end

      it 'should be published on the channel for the resource' do
        expect(channel).to be(channel)
      end

      it 'should supply a callback' do
        expect(pubnub_callback).to_not be_nil
      end

      its([:type]) { should == message_type }
      its([:':resource_id']) { should == resource_id }

      context 'when some params are given' do
        let(:params) { { a: 'b', c: 1, d: true } }

        its([:a]) { should == 'b' }
        its([:c]) { should == 1 }
        its([:d]) { should == true }
      end
    end
  end

  describe "#channel_for" do
    subject { pubnub_protocol.channel_for(resource_id) }

    let(:resource_id) { '/a/b/c' }

    it 'should return the channel ID to use to publish messages for the given resource' do
      expect(subject).to eq resource_id
    end
  end

  describe "#encode_identifier" do
    subject { pubnub_protocol.encode_identifier(identifier) }

    let(:identifier) { "/a-b?c#d e" }

    it 'should replace any reserved URI characters with "_"' do
      expect(subject).to eq '_a-b_c_d_e'
    end
  end
end