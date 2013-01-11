Introduction
============
http://github.com/SyntaxColoring/LM-Scripts

LM Scripts is a small collection of utilities designed for usage on LM's 1-to-1 computers.  The scripts are intended to help work around LM-specific issues that programmers might encounter.

Scripts
=======
All scripts output more detailed usage information when they are invoked without any arguments.

FakeInstall
-----------
Xcode comes with a number of command-line utilities (including the gcc toolchain), but they are not installed by default.  Installing them properly is trivial, but requires an administrator's username and password.

FakeInstall creates links to these tools and automatically adds them to the PATH variable **so that they can be used as if they were installed normally.**  This does not require any special permissions beyond regular programming permissions.  FakeInstall also supports supplying default arguments to the utilities every time they are invoked, which can fix some configuration issues that arise from using them like this.