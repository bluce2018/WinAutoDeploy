This is my sysprep that I run on Dell machines with drivers stored in c:\windows\inf.
It will load these drivers and set up the itsadmin account with the typical password.

put unattend.xml -> c:\windows\panther\
put setupcomplete.cmd -> c:\windows\setup\scripts\
put sysprep.cmd -> desktop, or anywhere

Capture an image before sysprepping in case something goes wrong.

When you're done, run sysprep.cmd and go make a sandwich. It will get things rolling, then delete itself and shut down.

Now, capture another image without letting Windows boot. This is the one you can deploy.

