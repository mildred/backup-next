Backup Drivers
==============

This directory contains the backup drivers. A driver can be either:

- a shell script (its name must be drivername`.sh`)
- an executable file (its name must be the driver name)

The choice of the driver is set in the backup directory, not here.

Shell Script Driver
-------------------

Shell script drivers are sourced within the backup tool. They must follow the
following pattern:

    driver=<driver name>_driver

    <driver>_driver(){
        local action="$1"
        shift
        <handle action $action with arguments $@>
    }

Executable Driver
-----------------

An executable driver is executed from the backup tool. The first argument is the
action to perform, the following arguments are the options for the action. Just
the same as the driver function described above.

Environment
-----------

When a driver is executed, the following environment variables are set:


  * `BACKUP_DRY_RUN`:
    `true` if the dirver should not explain what would be done instead of doing
    it. `false` otherwise.

  * `BACKUP_DIR`:
    The directory where the backup descriptor is found.

  * `BACKUP_DRIVER_DIR`:
    The directory where the driver is configured in the descriptor hierarchy.

  * `BACKUP_DRIVER_SOURCE_DIR`
    The driver directory (this directory)

Actions and Arguments
---------------------

  * `init <action>`:
    Initialize the driver for the given action (`backup`, `restore`, `list`)

  * `backup|list|restore <file> ...`
    Backup, list or restore the given file or directory `<file>`. Additional
    arguments are taken directly from the command line. If the file is a
    directory, it ends up with `/`.

  * `commit <action>`:
    Finalize the driver

