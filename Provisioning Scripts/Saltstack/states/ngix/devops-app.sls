include:
  - nginx

/etc/nginx/conf.d/devops-app.conf:
  file.managed:
    - source: salt://nginx/files/devops-app.conf
    - require_in:
      - service: nginx
    - watch_in:
      - service: nginx