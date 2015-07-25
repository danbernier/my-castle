$ tail -f /var/mail/dan   #-> so you can see the mail cron sends you when it fails

It seems like you're doing cron ok, but it can't load your profile.
It gets as far as RVM, then poops out.

# cron

See what's in cron:
$ crontab -l

Edit it:
$ crontab -e

Or load in a file:
$ crontab cron.file

Right now, cron is logging to ~/cron.log.


maid runs *great* when you run it from the command line.


# links

How to install ruby 2 sans RVM:
http://stackoverflow.com/questions/18490591/how-to-install-ruby-2-on-ubuntu-without-rvm

Info on ubuntu system variables:
https://help.ubuntu.com/community/EnvironmentVariables

Ben trying to help out someone in a similar fix:
https://github.com/benjaminoakes/maid/issues/103

Info on cron:
https://help.ubuntu.com/community/CronHowto
http://stackoverflow.com/questions/4811738/cron-job-log-how-to-log
