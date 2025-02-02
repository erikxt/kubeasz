[[inputs.jolokia2_agent]]
  name_prefix = "kafka_"

  ## If you intend to use "non_negative_derivative(1s)" with "*.count" fields, you don't need precalculated fields.
  # fielddrop   = [
  #   "*.EventType",
  #   "*.FifteenMinuteRate",
  #   "*.FiveMinuteRate",
  #   "*.MeanRate",
  #   "*.OneMinuteRate",
  #   "*.RateUnit",
  #   "*.LatencyUnit",
  #   "*.50thPercentile",
  #   "*.75thPercentile",
  #   "*.95thPercentile",
  #   "*.98thPercentile",
  #   "*.99thPercentile",
  #   "*.999thPercentile",
  #   "*.Min",
  #   "*.Mean",
  #   "*.Max",
  #   "*.StdDev"
  # ]

  ## jolokia_agent_url tag is not needed if you have only one instance of Kafka on the server.
  # tagexclude = ["jolokia_agent_url"]

  urls = ["http://localhost:{{ KAFKA_JOLOKIA_MONITOR_PORT }}/jolokia"]

  [[inputs.jolokia2_agent.metric]]
    name         = "controller"
    mbean        = "kafka.controller:name=*,type=*"
    field_prefix = "$1."

  [[inputs.jolokia2_agent.metric]]
    name         = "replica_manager"
    mbean        = "kafka.server:name=*,type=ReplicaManager"
    field_prefix = "$1."

  [[inputs.jolokia2_agent.metric]]
    name         = "purgatory"
    mbean        = "kafka.server:delayedOperation=*,name=*,type=DelayedOperationPurgatory"
    field_prefix = "$1."
    field_name   = "$2"

  [[inputs.jolokia2_agent.metric]]
    name         = "zookeeper"
    mbean        = "kafka.server:name=*,type=SessionExpireListener"
    field_prefix = "$1."

  [[inputs.jolokia2_agent.metric]]
    name     = "user"
    mbean    = "kafka.server:user=*,type=Request"
    field_prefix = ""
    tag_keys = ["user"]

  [[inputs.jolokia2_agent.metric]]
    name         = "request"
    mbean        = "kafka.network:name=*,request=*,type=RequestMetrics"
    field_prefix = "$1."
    tag_keys     = ["request"]

  [[inputs.jolokia2_agent.metric]]
    name         = "topics"
    mbean        = "kafka.server:name=*,type=BrokerTopicMetrics"
    field_prefix = "$1."

  [[inputs.jolokia2_agent.metric]]
    name         = "topic"
    mbean        = "kafka.server:name=*,topic=*,type=BrokerTopicMetrics"
    field_prefix = "$1."
    tag_keys     = ["topic"]

  [[inputs.jolokia2_agent.metric]]
    name       = "partition"
    mbean      = "kafka.log:name=*,partition=*,topic=*,type=Log"
    field_name = "$1"
    tag_keys   = ["topic", "partition"]

  [[inputs.jolokia2_agent.metric]]
    name       = "partition"
    mbean      = "kafka.cluster:name=UnderReplicated,partition=*,topic=*,type=Partition"
    field_name = "UnderReplicatedPartitions"
    tag_keys   = ["topic", "partition"]

## If you have multiple instances of Kafka on the server, use 'jolokia_agent_url' as identity of each instance
# [[processors.rename]]
#   namepass = ["kafka_*"]
#   order = 1
#   [[processors.rename.replace]]
#     tag = "jolokia_agent_url"
#     dest = "instance"
#
# [[processors.regex]]
#   namepass = ["kafka_*"]
#   order = 2
#   [[processors.regex.tags]]
#     key = "instance"
#     pattern = "^.+:8080/.+$"
#     replacement = "0"
#   [[processors.regex.tags]]
#     key = "instance"
#     pattern = "^.+:8081/.+$"
#     replacement = "1"
#   [[processors.regex.tags]]
#     key = "instance"
#     pattern = "^.+:8082/.+$"
#     replacement = "2"
