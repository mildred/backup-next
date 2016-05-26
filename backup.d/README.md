Backup Descriptor Directory
===========================

This directory should contain the backup descriptors. Backup descriptors
describe what should be backuped on the system and can configure a driver to do
so.

Depending of the file, the descriptor can have different types. Drivers can add
more types, and the default built-in types are:

  * **Directories with no extension or matching `*.d`:** This directory must
    contain other descriptors, and will run the defined action with each one of
    them.

  * **Links pointing to directories matching `*.{dir,link}`:** The
    content of that directory pointed by the symbolic link will be backed-up
    recursively.

  * **`*.exec`:** This file will be executed

  * **`*.sh`:** This file will be sourced as a shell script

  * **`*.md`, `*.txt`:** These files are ignored

  * Any other file extension can be defined by extensions.

The driver can be configured within a directory descriptor by adding a symbolic
link named `driver` or `driver.sh` in the directory pointing to the actual
driver. The driver is inherited in sub-directories.

Directory descriptor
--------------------

Directory descriptors contain sub descriptors which are executed when the
directory is executed. The sub descriptor must not be named `driver` or
`driver.sh` as this is reserved for driver configuration.

Link descriptor
---------------

A link descriptor must point to a valid location on the system that must be
backuped.

