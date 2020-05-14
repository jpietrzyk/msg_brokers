#!/usr/bin/env ruby
# encoding: utf-8

require "kafka"

logger = Logger.new($stderr)
brokers = ENV.fetch("KAFKA_BROKERS")

topic = "text"

kafka = Kafka.new(
  seed_brokers: brokers,
  client_id: "simple-producer",
  logger: logger,
)

producer = kafka.producer

begin
  $stdin.each_with_index do |line, index|
    producer.produce(line, topic: topic)

    # Send messages for every 10 lines.
    producer.deliver_messages if index % 10 == 0
  end
ensure
  # Make sure to send any remaining messages.
  producer.deliver_messages

  producer.shutdown
end
