Both don't seem to work because of the NFS provision I'm using.
Plus Velero requires an S3 bucket to perform backups and with Minio going full
terminal for free tier that dampens it a lot.

For now a cronjob is being used to perform the backups.