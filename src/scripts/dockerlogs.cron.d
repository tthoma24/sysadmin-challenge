#
# cron.d/dockerlogs -- Periodically copy Apache and MySQL logs to S3
#
# Written by tthoma24 9/23/17
#

# By default, run at 19:00 everyday
00 19 * * * root /data/scripts/dockerlogs.sh