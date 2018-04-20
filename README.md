# File & Directory Permission Saver and Restorer #

This script saves the current directory and child files & subdirecties ownership and permissions to a text file

It is useful if you run Wordpress, Joomla, Drupal, CakePHP or other CMS with restricted permissions but then want to temporarily relax the permissions to allow writing to files and directories during upgrades.

When you are finished you can restore the permissions from the file

Do it as follows:

```
./perm_saver.pl store
./perm_saver.pl restore
```

or you can use a different filename to store the different versions of directory permissions

```
./perm_saver.pl store anotherfile
./perm_saver.pl restore anotherfile
```

Works on mac and linux

james@toggen.com.au
