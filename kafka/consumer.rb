#!/usr/bin/env ruby
# encoding: utf-8

require "kafka"

logger = Logger.new(StringIO.new)

brokers = ENV.fetch("KAFKA_BROKERS").split(",")

# Make sure to create this topic in your Kafka cluster or configure the
# cluster to auto-create topics.
topic = "text"

kafka = Kafka.new(
  seed_brokers: brokers,
  client_id: "simple-consumer",
  socket_timeout: 20,
  logger: logger,
)

kafka.each_message(topic: topic) do |message|
  puts message.value
end
