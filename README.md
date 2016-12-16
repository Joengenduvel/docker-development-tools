# development-machine

## Goal
This images provides a linux machine with all the tools needed to do develop java, C# and javascript applications.
For the moment everything is installed in the same machine.

To use applications with a frontend, you will need an X server installed on your host.
### Windows
You will need to install an X server for Windows.
I went for [Vcxsrv](https://sourceforge.net/projects/vcxsrv/).
The `DISPLAY` environment variable points by default to 192.168.1.1.
If you use docker on Windows 10, this should be ok.

To configure Vcxsrv, start Xlaunch.
It will prompt with some questions of what options you want to set.
Make sure you add the extra option `-rootless` in the last screen.
Save this configuration file in one of these locations:
* %appdata%\Xming
* %userprofile%\Desktop
* %userprofile%
* Xming install directory.

### Linux
If you have a desktop environment installed, you can use the excisting X server of your host.
Replace the IP in the `DISPLAY` environment variable with your host's IP or hostname.

## This machine includes
* Oracle Java 8 JDK
* Intellij 2016.3
* Visual Studio Code

## Known issues
* menus of Visual Studio Code are slow

## Usage
Run the container using
```
docker run joengenduvel/intellij
```
