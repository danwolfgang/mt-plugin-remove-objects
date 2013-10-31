# Remove Objects plugin for Movable Type

The Remove Objects plugin provides a way for administrators to easily delete
objects in Movable Type.

"But I can just click the Delete button on the Edit Entry screen." True, but
there are many other types of objects you may want to delete and some of them
don't have a Delete button. Plus, if you've got a bunch to delete, going one at
a time can be a pain.

"But I can just go to the database and delete the row." You can, but you
shouldn't. Movable Type is a *relational* database, so often stores some pieces
in one table and some pieces in another table. Directly editing the database is
a great way to fragment your install. This plugin uses the object's `remove`
method to correctly delete objects.

"But Movable Type comes with the simple `tools/remove-object` script." Yes!
This plugin is most like that script, but better in two ways: this plugin will
allow you to delete multiple objects at one time, and this plugin will log the
deletion to the Activity Log for a "paper trail." Additionally, you don't need
to figure out the object class to use this plugin; just choose it from the list
of available object types.

You'll need System Administrator privileges to use this plugin. Also, and I can
not overstate this enough, you can completely destory your installation with
this plugin by deleting different objects. Be sure you know what you want to
delete before charging in!

# Prerequisites

* Movable Type 4.x
* Movable Type 5.x
* Movable Type 6.x

# Installation

To install this plugin follow the instructions found here:

http://tinyurl.com/easy-plugin-install

# Use

Only System Administrators can use this plugin. At the System Overview level,
go to Tools > Remove Objects. Choose the object type and specify the object IDs
to be deleted. Click Delete.

# License

This plugin is licensed under the same terms as Perl itself.

# Copyright

Copyright 2013, uiNNOVATIONS LLC. All rights reserved.
