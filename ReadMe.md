Introduction
============
[LM Scripts](http://github.com/SyntaxColoring/LM-Scripts) is a small collection of tools for programming on LMSD's 1-to-1 laptops.  Each tool is designed to work around an LM-specific issue that might annoy programmers and power-users.

Since these are command-line tools, you need programming permissions to use them.  Generally, that means you have to be currently enrolled in a computer science course.  There's no way around this requirement, unfortunately.

Each tool is described below.  For specific usage instructions on a given tool, invoke it without any arguments.

FakeInstall
===========
**Makes Xcode's command-line tools available for use.**

Xcode comes with a bunch of command-line utilities (including the gcc toolchain), but you need an admin password to install them.  FakeInstall creates links to these tools and automatically adds them to PATH so that you can use them as if they were installed normally.  This only requires regular programming permissions.

FakeInstall also supports supplying default arguments to the utilities every time they are invoked.  This is necessary to fix some configuration issues that arise from running the tools without properly installing them.

FakeMount
=========
**Extracts the contents of .dmg files.**

Apple disk images (.dmg files) are probably the most common way of distributing software for OS X.  Of course, we don't have the permissions to use them.  FakeMount uses a combination of tools to attempt to extract a .dmg file's contents without actually mounting it, thereby bypassing the need for admin credentials.

This tool currently has three huge limitations:

  1. It simply cannot extract some .dmg files.  For example, the last time I checked, it does not work with the .dmgs for Opera or uTorrent.
  2. It relies on proprietary 3rd-party freeware for part of the process.  With your permission, FakeMount will automatically download [PowerISO](http://www.poweriso.com) if you don't already have it.
  3. The original files' permissions are lost entirely.  This really only matters if you're trying to install an application, in which case executable files will not actually be executable (oops).  With this in mind, FakeMount will automatically look for files that look like they *should* be executable and mark them as such.  This "band-aid" fix works for every case I've tried, but it's still something to watch out for.

FakeMount works like this:

    .dmg -> [Convert] -> .iso -> [Extract] -> .app/folder -> [Fix executables]

The input files can be .dmg files, .iso files or folders, in case part of this process has already been done.  (.app files are really just folders.)  There are also options for stopping before the extraction or executable-fix steps, in case you don't want to do the entire process.
