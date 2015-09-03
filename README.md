# Perl Directory Permission Saver and Restorer #

This script saves the current and child subdirectory permissions to a text file

You then can change the permissions to what you need such as when updating modules on an install of Joomla or other CMS

When you are finished you can restore the directory perms from the file

`./perm_saver.pl store`
`./perm_saver.pl restore`

or you can use a different filename to store the different versions of directory permissions
 
`./perm_saver.pl store anotherfile`
`./perm_saver.pl restore anotherfile`

Works on mac and linux
