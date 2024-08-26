return function(config)
  config.ssh_domains = {} -- Disable SSH domains
  config.unix_domains = {} -- Disable unix domains
  config.tls_clients = {} -- Disable TLS domains
  config.tls_servers = {} -- Disable TLS domains
  config.wsl_domains = {} -- Disable WSL domains
end
