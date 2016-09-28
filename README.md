Backup system
=============

This backup system works by putting files in `/etc/backup.d`. It can support a
number of different backends. Currently, there is only rdiff-backup and duplicity implemented.

Installing
----------

* Copy `backup` to some place in the `$PATH`, generally `PREFIX/bin`
* Create a directory for your drivers, generally `PREFIX/share/backup/drivers`
* You can install the drivers found in the `drivers` directory to
  `PREFIX/share/backup/drivers` or you can create your own drivers.
* Create a directory /etc/backup.d to receive the backup descriptors.

Usage
-----

  * `backup backup DESCRIPTOR`

    Where `DESCRIPTOR` is the full path to a descriptor generally found in
    `/etc/backup.d`. This command will backup the files according to the
    descriptor.

  * `backup restore DESCRIPTOR [...]`

    Where `DESCRIPTOR` is the full path to a descriptor generally found in
    `/etc/backup.d`. This command will restore the files last backed-up by the
    same descriptor. Additional arguments an be passed to the backend.

  * `backup list DESCRIPTOR`

    List the backups made by the descriptor

  * `backup help`

    Print some help.

Drivers
-------

The descriptor describe what files must be backed-up. It is always associated
with a driver, which describes how to back-up the files.

The driver can add more descriptor types and can handle some configuration files
if wanted.

To find the driver for a given descriptor, the backup system will try to find a
file named `driver` or `driver.sh` that is in the same directory as the
descriptor. The `driver` or `driver.sh` is generally a symbolic link pointing to
a driver implementation in `PREFIX/share/backup/drivers/`.

A special case for subdirectory descriptors that look for their drivers inside
their directory.

Default Descriptor Types
------------------------

See the README.md file in backup.d

The rdiff-backup driver
-----------------------

This driver will look for a file named `rdiff-backup.conf` next to the `driver`
file. It is a shell script that can changes the following variables :

* **`DESTINATION` (mandatory):** Where to backup to
* **`AUTO_PRUNE`:** If `true`, remove files older than `AUTO_PRUNE_DELAY` during
  backup. Default is `false`.
* **`AUTO_PRUNE_DELAY`:** argument to `--auto-prune-delay` when `AUTO_PRUNE` is
  `true`. Default is `1W`

The duplicity driver
--------------------

This driver looks for a file named `duplicity.conf` next to the `driver` file. It is a shell script that can change the following variables:

* **`DESTINATION` (mandatory):** Where to backup to
* **`AUTO_PRUNE`:** If `true`, remove files older than `AUTO_PRUNE_DELAY` during
  backup. Default is `false`. Executes `duplicity remove-older-than`.
* **`AUTO_PRUNE_DELAY`:** remove files older than this delay if `AUTO_PRUNE` is
  `true`. Default is `1W`
* **`FULL_BACKUP_PERIOD`:** run a full backup instead of an incremental backup if the full backup is older than this period. Defaults to the auto prune delay.
* **`FLAGS`:** additional duplicity flags (bash array)
