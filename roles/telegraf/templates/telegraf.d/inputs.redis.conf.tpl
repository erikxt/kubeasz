# Read Redis's basic status information
[[inputs.redis]]
  ## specify servers via a url matching:
  ##  [protocol://][:password]@address[:port]
  ##  e.g.
  ##    tcp://localhost:6379
  ##    tcp://:password@192.168.99.100
  ##    unix:///var/run/redis.sock
  ##
  ## If no servers are specified, then localhost is used as the host.
  ## If no port is specified, 6379 is used
{% set cluster_address=[] -%}
{% for host in groups['redis_cluster'] %}
{% set _ = cluster_address.append('"tcp://%s:%s"' % (host, REDIS_PORT )) -%}
{% endfor %}
  servers=[{{ cluster_address | join(',') }}]

  ## Optional. Specify redis commands to retrieve values
  # [[inputs.redis.commands]]
  #   # The command to run where each argument is a separate element
  #   command = ["get", "sample-key"]
  #   # The field to store the result in
  #   field = "sample-key-value"
  #   # The type of the result
  #   # Can be "string", "integer", or "float"
  #   type = "string"

  ## specify server password
  # password = "s#cr@t%"

  ## Optional TLS Config
  # tls_ca = "/etc/telegraf/ca.pem"
  # tls_cert = "/etc/telegraf/cert.pem"
  # tls_key = "/etc/telegraf/key.pem"
  ## Use TLS but skip chain & host verification
  # insecure_skip_verify = true
