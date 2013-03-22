Introduction
============
[LM Scripts](http://github.com/SyntaxColoring/LM-Scripts) is a small collection of tools for programming on LMSD's 1-to-1 laptops.  Each tool is designed to work around an LM-specific issue that might annoy programmers and power-users.

Since these are command-line tools, you need special programming permissions to use them.  As of 2012, programming permissions are no longer granted by default to computer science students.  If you want them, you need to be able to make a strong argument that you will use them for educational purposes.  Unfortunately, there's no way around this other than bypassing the firmware password lock (which is at your own risk and beyond the scope of this project).

The tools that come with LM Scripts are summarized below.  For specific usage instructions on a given tool, execute it without any arguments.

FakeMount
=========
**Extracts the contents of .dmg files.**

Apple disk images (files that end with ".dmg") are probably the most common way of distributing software for OS X.  Of course, we don't have the permissions to use them.  FakeMount uses a combination of tools to attempt to extract a .dmg file's contents without actually mounting it, thereby bypassing the need for admin credentials.

There are three important things to note about FakeMount:

  1. Some .dmg files, like the ones for Opera and uTorrent, simply cannot be extracted.  Sorry.
  2. [PowerISO](http://www.poweriso.com), a third-party closed-source freeware tool, is required for part of the process.  With your permission, FakeMount will automatically download PowerISO if you don't already have it.
  3. The original files' permissions are lost entirely.  This really only matters if you're trying to install an application, in which case executable files will not actually be executable (oops).  With this in mind, FakeMount will automatically look for files that look like they *should* be executable and mark them as such.  This is a "band-aid" fix, but it has worked well so far.

The full FakeMount process looks like this:

    .dmg -> [Convert] -> .iso -> [Extract] -> .app/folder -> [Fix executables]

FakeInstall
===========
**Installs Xcode's command-line tools.**

Xcode comes with a bunch of command-line utilities (including the gcc toolchain), but you need an admin password to install them.  FakeInstall makes it so that you can use them as if they were installed normally.  It does this by creating links to these tools and automatically addding them to `$PATH`, which only requires regular programming permissions!

FakeInstall also supports supplying default arguments to the utilities every time they are invoked.  This is necessary to fix some configuration issues that arise from running the tools without properly installing them.

Tools are normally installed individually, but a set of reccommended tools can be installed all at once with the `--Suggestions` option.  `--Suggestions` provides everything that most programmers will need.

UpdateD
=======
**Installs and updates a compiler for the [D programming language](http://dlang.org).**

This is a convenience script for managing the [DMD compiler](http://github.com/D-Programming-Language/dmd) and its dependencies.  Existing installations can be updated and new installations can be created.  Everything is done automatically, from downloading and compiling the source to updating `$PATH` and creating dmd.conf.

It is a good idea to run `FakeInstall --Suggestions` before trying to use this tool.

InstallScripts
==============
**Installs LM Scripts itself.**

This is a tiny convenience script that, with your confirmation, adds the LM Scripts directory to `$PATH`.  For ease of use, this script does not expect any arguments.  Its icon in Finder can just be double-clicked to install LM Scripts for the command-line.

Running InstallScripts is by no means mandatory.  Adding LM Scripts to `$PATH` simply makes it so that the tools from LM Scripts can be run over the command-line without needing to specify their location every time.  Here's an example:

    # Always valid.
    /Users/Shared/MyLMScriptsDirectory/FakeMount Foo.dmg
    
    # This is also always valid.
    cd /Users/Shared/MyLMScriptsDirectory
    ./FakeMount Foo.dmg
    
    # Only works after running InstallScripts!
    FakeMount Foo.dmg

Hide
====
**Makes files and folders invisible.**

Hide is a small novelty script that can make files invisible (and visible again) to Finder.  It works on folders as well as regular files.
