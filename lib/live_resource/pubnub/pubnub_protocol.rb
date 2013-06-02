require 'live_resource/protocol'

module LiveResource
  module Pubnub

    class PubnubProtocol
      include LiveResource::Protocol

      def initialize(pubnub)
        @pubnub = pubnub
      end

      def publish_message(resource_identifier, type, params = nil)
        params     ||= {}
        channel_id = channel_for(resource_identifier)

        message = params.merge(
            :type           => type,
            :':resource_id' => resource_identifier,
        )

        @pubnub.publish(
            params.merge(
                :channel  => channel_id,
                :message  => message,
                :callback => ->(x) {}
            ))
      end

      def channel_for(resource_id)
        resource_id
      end

      def encode_identifier(identifier)
        permitted_characters = URI::REGEXP::PATTERN::UNRESERVED
        identifier.gsub(/[^#{permitted_characters}]/, '_')
      end

    end

  end
end