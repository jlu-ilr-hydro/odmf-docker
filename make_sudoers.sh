# This file creates sudoers.d entries for all ODMF databases intalled at this computer, to
# allow DB-admins to do interactive sessions
SUDOERS=/etc/sudoers.d/odmf.sudoers

echo "# SUDOer group permissions for interactive use of ODMF" > $SUDOERS \
  || echo "Failed to create $SUDOERS, are you root?" \
  && exit 1

for DB in /srv/odmf/*
do
  echo "%odmf-$DB ALL=(root) NOPASSWD: /srv/odmf/$DB/exec" | EDITOR="tee -a" visudo $SUDOERS
done