## Disk Space Alert
https://community.grafana.com/t/set-alerts-for-when-cpu-load-hard-disk-reaches-85-in-grafana-datasource-using-prometheus/70800
https://stackoverflow.com/questions/76702740/join-prometheus-queries-while-keeping-data-from-the-left-side
https://signoz.io/guides/how-can-i-group-labels-in-a-prometheus-query/
https://stackoverflow.com/questions/49896956/relabel-instance-to-hostname-in-prometheus
https://rithwik.hashnode.dev/low-disk-space-alert-using-grafana-prometheus-node-exporter?ref=twitter-share

#### Query:
(max(100 - ((node_filesystem_avail_bytes * 100) / node_filesystem_size_bytes)) by (instance)) 
*
on(instance) group_left(nodename) node_uname_info

#### Notification Annotation
Summary: Node "{{ $labels.nodename }}" used over 75% of disk space. 

Description: "{{ $labels.nodename }}" has used {{ $values.A.value }} of their disk.



## Slack Webhook
https://api.slack.com/messaging/webhooks
https://prometheus.io/docs/alerting/latest/notification_examples/
https://stackoverflow.com/questions/39389463/using-alert-annotations-in-an-alertmanager-receiver


#### Notification Templates
{{ define "__slack_text" }}                                                                                                                                                
{{ range .Alerts }}{{ .Annotations.description }}{{ end }}                                                                                
{{ end }}

{{ define "__slack_title" }}                                                                                                                                                
{{ range .Alerts }}{{ .Annotations.summary }} {{ end }}                                                                                
{{ end }}


#### Slack Title and Text Template

Title: {{ template "__slack_title" . }}
Description: {{ template "__slack_text" . }}


