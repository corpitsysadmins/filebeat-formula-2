filebeat.service:
  service.running:
    - name: filebeat
    - enable: true
    - require:
      - pkg: filebeat
    - watch:
      - file: /etc/filebeat/filebeat.yml
