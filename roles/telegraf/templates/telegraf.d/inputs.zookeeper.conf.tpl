[[inputs.zookeeper]]
  ## An array of address to gather stats about. Specify an ip or hostname
  ## with port. ie localhost:2181, 10.0.0.1:2181, etc.

  ## If no servers are specified, then localhost is used as the host.
  ## If no port is specified, 2181 is used
{% set cluster_address=[] -%}
{% for host in groups['zookeeper_cluster'] %}
{% set _ = cluster_address.append('"%s:%s"' % (host, ZOOKEEPER_PORT )) -%} 
{% endfor %}
  servers=[{{ cluster_address | join(',') }}]

  ## Timeout for metric collections from all servers.  Minimum timeout is "1s".
  # timeout = "5s"

  ## Optional TLS Config
  # enable_tls = true
  # tls_ca = "/etc/telegraf/ca.pem"
  # tls_cert = "/etc/telegraf/cert.pem"
  # tls_key = "/etc/telegraf/key.pem"
  ## If false, skip chain & host verification
  # insecure_skip_verify = true