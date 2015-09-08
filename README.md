# eea.docker.daviz

This document explains how to install and run a Plone instance (with the _EEA Daviz_ add-on installed) from a Docker container.

### Contents ###

* A. [About containers and Docker](#A)
* B. [Installing Docker](#B)
  - B.1 [Linux](#B1)
  - B.2 [Windows](#B2)
  - B.3 [Mac OS X](#B3)
* C. [Building and running the Plone-Daviz container](#C)
  - C.1 [Using the `docker-compose` command (Linux and OS X)](#C1)
  - C.2 [Using the `docker` command (Windows)](#C2)
* D. [Accessing the Plone-Daviz instance from your web browser](#D)
  - D.1 [Linux](#D1)
  - D.2 [Windows and OS X](#D2)
* E. [Creating the Plone site](#E)

### <a name="A"></a> A. About containers and Docker ###

In short, you can think of a _container_ as an isolated environment within an operating system in which applications and processes can be executed independently of the other processes running on the host machine.
_Docker_ is a software which automates the deployment of applications inside containers.
_Docker containers_ can be built and deployed only on a Linux operating system - that is, the prerequisite for building and running Docker containers is to have an underlying Linux environment. This means that Docker cannot be installed directly under non-Linux operating systems (such as Windows); it is necessary to first create a Linux environment and then install Docker.

More information about Docker can be found here: _[What is Docker](https://www.docker.com/whatisdocker "What is Docker")._

### <a name="B"></a> B. Installing Docker ###

In order to build and run a container, you first need to install Docker. The installation steps to be taken depend on the operating system of your computer, as follows:

#### <a name="B1"></a> B.1 Linux ####

The way to install Docker varies depending on the Linux distribution on your computer. You can find specific installation instructions for your distribution here: _[Docker Installation](https://docs.docker.com/installation/ "Docker Installation")_.

#### <a name="B2"></a> B.2 Windows ####

Because Docker relies on Linux-specific features, you can’t install it and run it natively in Windows. One approach is to install the _Docker Toolbox_ application which sets up a specific Docker environment on your computer. The Toolbox installs a set of tools which allows you to manage and run Docker containers; in addition to the core Docker software, it installs other software such as Oracle _VirtualBox_ and _Git_.

There are two requirements in order to be able to install the Docker Toolbox:  
- Windows _Version_ - your machine must be running Windows 7 or newer;  
- Windows _Virtualization_ - make sure that your Windows supports Hardware Virtualization Technology and that virtualization is enabled.  
\> for Windows 8/8.1 or newer, choose Start > Task Manager and navigate to the Performance tab. Under CPU, the Virtualization setting should show “Enabled”; If virtualization is not enabled on your system, follow the manufacturer’s instructions for enabling it;  
\> for Windows 7, run the _[Microsoft Hardware-Assisted Virtualization Detection Tool](http://www.microsoft.com/en-us/download/details.aspx?id=592 "Microsoft Hardware-Assisted Virtualization Detection Tool")_ and follow the instructions.

If you already have installed the VirtualBox, there is no need to uninstall it. When prompted by the Docker Toolbox installer, indicate not to reinstall VirtualBox. If you have VirtualBox runnig, shut it down.

Follow these steps to install Docker Toolbox:  
1. Navigate to the _[Docker Toolbox](https://www.docker.com/toolbox "Docker Toolbox")_ page and click the installer link to download it.  
2. Double-click the installer to launch the Docker Toolbox setup wizard. If the Windows security dialog prompts you to allow the program to make changes to your computer, choose Yes.  
3. Follow the steps prompted by the wizard by pressing Next; when prompted with the “Select Components” screen, uncheck “VirtualBox” if you already have it installed on your computer.  
4. Press Install to start the actual installation. If notified by Windows Security that the installer will make changes, make sure you allow the installer to make the necessary changes.  
5. When it completes, the installer reports it was successful. Uncheck “View Shortcuts in File Explorer” and press Finish.

Launch a Docker Toolbox _terminal_ by double-clicking the “Docker Quickstart Terminal” icon on your Desktop. If the system displays a User Account Control prompt to allow VirtualBox to make changes to your computer, choose Yes.  
The terminal does several things to set up Docker Toolbox for you. When it is done, the terminal displays the **`$`** prompt where you can type bash commands; the terminal runs a special _bash_ environment instead of the standard Windows command prompt, since the bash environment is required by Docker.

More information about installing Docker and working with containers can be found here: _[Get Started with Docker for Windows](http://docs.docker.com/windows/started/ "Get Started with Docker for Windows")_.

#### <a name="B3"></a> B.3 Mac OS X ####

Because Docker relies on Linux-specific features, you can’t install it and run it natively in OS X. One approach is to install the _Docker Toolbox_ application which sets up a specific Docker environment on your computer. The Toolbox installs a set of tools which allows you to manage and run Docker containers; in addition to the core Docker software, it installs other software such as _Oracle VirtualBox_ and _Git_.

One requirement in order to be able to install the Docker Toolbox is the OS X _version_. Your machine must be running OS X 10.8 “Mountain Lion” or newer. Choose “About this Mac” from the Apple menu to find out the version of your OS.

If you already have installed the VirtualBox, there is no need to uninstall it. When prompted by the Docker Toolbox installer, you can indicate to upgrade VirtualBox. If you have VirtualBox runnig, shut it down.

Follow these steps to install Docker Toolbox:  
1. Navigate to the _[Docker Toolbox](https://www.docker.com/toolbox "Docker Toolbox")_ page and click the installer link to download it.  
2. Double-click the installer to launch the Docker Toolbox setup wizard.  
3. Follow the steps prompted by the wizard by pressing Continue.  
4. Press Install to start the actual installation. If the system prompts you for your password, provide it and continue with the installation.  
5. When it completes, the installer provides you some shortcuts which you can immediately use to get started with Docker. You can ignore this for now and click Continue to finish the installation.

Launch a Docker Toolbox _terminal_ by clicking the “Docker Quickstart Terminal” icon from the Launchpad. The terminal does several things to set up Docker Toolbox for you. When it is done, the terminal displays the **`$`** prompt where you can type _bash_ commands; the terminal runs a special bash environment instead of the standard Windows command prompt, since the bash environment is required by Docker.

More information about installing Docker and working with containers can be found here: _[Get Started with Docker for Mac OS X](http://docs.docker.com/mac/started/ "Get Started with Docker for Mac OS X")_.

### <a name="C"></a> C. Building and running the Plone-Daviz container ###

There are two ways of building and running a Docker container using the terminal:  
- by issuing the `docker` command and manually specifying configuration parameters of the container at the terminal prompt (parameters such as the name of the container, ports to be used for accessing the container etc.);  
- by issuing the `docker-compose` command which automatically reads the configuration parameters of the container from an existing configuration file (e.g.: the “docker-compose.yml” file).

A good practice is to use the `docker-compose` command. Given the fact that, for now, the Docker Toolbox version for Windows does not support this command, the `docker` command can be used instead.

First of all, issue the following command (without the “$”):

**$** `git clone https://github.com/eea/eea.docker.daviz.git`

This will create a folder named “eea.docker.daviz” which contains the necessary files to build and run the Plone-Daviz container (e.g. “docker-compose.yml”, “buildout.cfg”). This folder will be your _repository directory_ from which you launch specific Docker commands. To navigate inside this folder, run this:

**$** `cd eea.docker.daviz/`

#### <a name="C1"></a> C.1 Using the **`docker-compose`** command (Linux and Mac OS X) ####

Using the terminal (for OS X, the Docker Toolbox terminal), navigate to your repository directory and issue the following command (without the “$”):

**$** `docker-compose up`

This will both _create_ and _start_ the Docker container which has the Plone-Daviz instance in it. The command runs for a while and does several things in order to set up the container. When it is finished, the message “Ready to handle requests” will apear on the terminal screen, indicating that the container has been created and is currently started (meaning that it is in the “started” state). After issuing this command, you are not able to issue further commands, since the terminal prompt is not available to you. To make it available, you can press “CTRL-c”, but by doing so, you might stop the Plone-Daviz container, thus bringing it in the “stopped” state. The container will not be removed, but only stopped.  

To see the container's current status, issue the following command:

**$** `docker-compose ps`

A state of “Up” means that the container is started, and a state of “Exit” means that it is stopped.

In case it is stopped, to start again the Plone-Daviz container, issue this command:

**$** `docker-compose start`

This command will bring the container into the “started” state; it will not build again the container (since it was already built by the `docker-compose up` command), but it will only start it. If needed, you may stop or restart the container by issuing one of the following commands:

**$** `docker-compose stop`  
**$** `docker-compose restart`

You are able to access the Plone-Daviz instance from your web browser only if the Plone-Daviz container is in the “started” state.

_Note_: you are able to issue the `docker-compose up` command multiple times, but by doing so, be aware that the Plone-Daviz container will not only be started, but also be re-created. This means that any changes previously performed to the Plone-Daviz instance (via the web browser) will be _lost_.

#### <a name="C2"></a> C.2 Using the **`docker`** command (Windows) ####

First, you need to identify the **full path** of your repository directory, that is the complete sequence of folders from the root directory (/) up to your repository directory (for example, the format of a full path could look like this: “/home/user/.../repository_directory”). While located in your repository directory, you can easily find the full path just by issuing the following command:

**$** `pwd`

Using the Docker Toolbox terminal, while located in your repository directory, issue the following command (without the “$”):

**$** `docker run -p 80:80 -v REPOSITORY_DIRECTORY/buildout.cfg:/opt/zope/buildout.cfg --name plone_daviz_container eeacms/plone` ,  
where REPOSITORY\_DIRECTORY is the full path of your repository directory.

If the command fails and a “invalid value ... for flag -v”-alike error message is raised, re-issue the command after adding an additional slash “/” character next to the existing ones in the paths after the “-v” flag. For example, if your initial command was similar to this one:

**$** `docker run -p 80:80 -v /home/user/.../repository_directory/buildout.cfg:/opt/zope/buildout.cfg --name plone_daviz_container eeacms/plone`  
then change it like this:  
**$** `docker run -p 80:80 -v //home//user//...//repository_directory//buildout.cfg://opt//zope//buildout.cfg --name plone_daviz_container eeacms/plone`  
(note that the “`/`” from “`eeacms/plone`” should not be doubled)

The command will both _create_ and _start_ a Docker container named “plone\_daviz\_container” which has the Plone-Daviz instance in it. The command runs for a while and does several things in order to set up the container. When it is finished, the message “Ready to handle requests” will apear on the terminal screen, indicating that the container has been created and is currently started (meaning that it is in the “started” state). After issuing this command, you are not able to issue further commands, since the terminal prompt is not available to you. To make it available, you can press “CTRL-c”, but by doing so, you might stop the “plone\_daviz\_container” container, thus bringing it in the “stopped” state. The container will not be removed, but only stopped.

To see the container's current status, issue the following command and look for the container named “plone\_daviz\_container”:

**$** `docker ps -a`

A state of “Up” means that the container is started, and a state of “Exit” means that it is stopped.

In case it is stopped, to start again the Plone-Daviz container, issue this command:

**$** `$ docker start plone_daviz_container`

This command will bring the container into the “started” state; it will not build again the container (since it was already built by the `docker run` command), but it will just start it. If needed, you may stop or restart the container by issuing one of the following commands:

**$** `docker stop plone_daviz_container`  
**$** `docker restart plone_daviz_container`

You are able to access the Plone-Daviz instance from your web browser only if the Plone-Daviz container is in the “started” state.

### <a name="D"></a> D. Accessing the Plone-Daviz instance from your web browser ###

#### <a name="D1"></a> D.1 Linux ####

As long as the Plone-Daviz container is in the “started” state, you are able to access the Plone instance from the web browser. To do that, enter “localhost” or “127.0.0.1” in the address bar of the browser. Alternatively, you can type "http://localhost:80" or "http://127.0.0.1:80". After pressing Enter, the Plone start page should be displayed. Again, note that this works as long as the container is _started_.

#### <a name="D2"></a> D.2 Windows and OS X ####

In order to access the Plone-Daviz instance using the web browser, you first need to identify the IP address of the Docker environment on your computer. Issue the following command to accomplish this:

**$** `echo $DOCKER_HOST`

This should display an address which has the following format: “protocol://**ip\_address**:port” (for example “tcp://192.168.99.100:2376”). Open a web browser and enter the IP address (only **ip\_address**) in the address bar of the browser. Alternatively, you can type "http://**ip\_address**:80". After pressing Enter, the Plone start page should be displayed on your browser. Note that this works as long as the Plone-Daviz container (named “plone\_daviz\_container”) is in a running state.
Note: in Windows, if you are using the Internet Explorer browser and after entering the IP address in the address bar the Plone start page does not show, you might try using another web browser (e.g. Google Chrome).

### <a name="E"></a> E. Creating the Plone site ###

Once you have the Plone start page displayed on your browser, click the “Create a new Plone site” button. You are prompted to authenticate in order to proceed further. Type _admin_ for both User Name and Password.

Next, you are presented with a page in which you can set up several options for your site:  
- the ID of the site, which will end up as part of the site's address/URL;  
- the Title of the site, which will be shown in the title of the browser window on each page;  
- the main Language of the site;  
- the Add-ons you want to activate for you site. Here, make sure that you check the box next to “**EEA Daviz**”.

Once you click the “Create Plone Site” button, you are presented with the default page of your site. Now you can perform changes and start using the EEA Daviz feature. To learn how to use it, navigate here: [EEA Daviz](http://eea.github.io/docs/eea.daviz/index.html "EEA Daviz").

