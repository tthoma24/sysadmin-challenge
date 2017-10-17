#
# cron.d/dockerbackups -- Periodically backu Apache and MySQL Docker containers to S3
#
# Written by tthoma24 9/23/17
#

# By default, run at 19:15 everyday
15 19 * * * root /data/scripts/dockerbackups.sh