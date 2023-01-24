#cloud-config
---
update_hostname: ${hostname}
package_update: true
package_upgrade: true
write_files:
  - path: /etc/apt/apt.conf.d/90pkgs-nginx
    owner: root
    permissions: "0644"
    content: |
      Acquire::https::pkgs.nginx.com::Verify-Peer "true";
      Acquire::https::pkgs.nginx.com::Verify-Host "true";
      Acquire::https::pkgs.nginx.com::SslCert "/etc/ssl/nginx/nginx-repo.crt";
      Acquire::https::pkgs.nginx.com::SslKey "/etc/ssl/nginx/nginx-repo.key";
  - path: /etc/ssl/nginx/nginx-repo.crt
    owner: root
    permissions: "0644"
    encoding: b64
    content: |
      ${nginx-repo-crt}
  - path: /etc/ssl/nginx/nginx-repo.key
    owner: root
    permissions: "0644"
    encoding: b64
    content: |
      ${nginx-repo-key}
apt:
  preserve_sources_list: false
  sources:
    tailscale.list:
      source: deb https://pkgs.tailscale.com/stable/ubuntu focal main
      keyid: 2596A99EAAB33821893C0A79458CA832957F5868
    nginx-plus.list:
      source: deb https://pkgs.nginx.com/plus/ubuntu $RELEASE nginx-plus
      keyserver: https://cs.nginx.com/static/keys/nginx_signing.key
      keyid: 7BD9BF62
packages: 
  - tailscale
  - awscli
  - nginx-plus
runcmd:
  - [ hostnamectl, set-hostname, ${hostname} ]
  - [ systemctl, start, nginx]
