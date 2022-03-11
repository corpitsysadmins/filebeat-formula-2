{% from "filebeat/map.jinja" import conf with context %}

{% set ssl_cert = salt['pillar.get']('filebeat:logstash:tls:ssl_cert', 'salt://filebeat/files/ca.pem') %}
{% set ssl_cert_path = salt['pillar.get']('filebeat:logstash:tls:ssl_cert_path') %}
{% set managed_cert = salt['pillar.get']('filebeat:logstash:tls:managed_cert', True) %}
{% set ssl_key = salt['pillar.get']('filebeat:logstash:tls:ssl_key') %}
{% set ssl_key_path = salt['pillar.get']('filebeat:logstash:tls:ssl_key_path') %}
{% set ssl_ca = salt['pillar.get']('filebeat:logstash:tls:ssl_ca') %}
{% set ssl_ca_path = salt['pillar.get']('filebeat:logstash:tls:ssl_ca_path') %}

{% if salt['pillar.get']('filebeat:logstash:tls:enabled', False) and ssl_cert and ssl_cert_path and managed_cert %}
{{ ssl_cert_path }}:
  file.managed:
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 644
    - contents_pillar: filebeat:logstash:tls:ssl_cert
    - watch_in:
      - filebeat.config
{% endif %}


{% if salt['pillar.get']('filebeat:logstash:tls:enabled', False) and ssl_key and ssl_key_path and managed_cert %}
{{ ssl_key_path }}:
  file.managed:
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 644
    - contents_pillar: filebeat:logstash:tls:ssl_key
    - watch_in:
      - filebeat.config
{% endif %}

{% if salt['pillar.get']('filebeat:logstash:tls:enabled', False) and ssl_ca and ssl_ca_path and managed_cert %}
{{ ssl_ca_path }}:
  file.managed:
    - template: jinja
    - makedirs: True
    - user: root
    - group: root
    - mode: 644
    - contents_pillar: filebeat:logstash:tls:ssl_key
    - watch_in:
      - filebeat.config
{% endif %}

filebeat.config:
  file.managed:
    - name: {{ conf.config_path }}
    - source: {{ conf.config_source }}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
