# eea.docker.daviz

This document explains how to install and run a Plone instance (with the _EEA Daviz_ add-on installed) from a Docker container.


### Installing Docker ###

In order to build and run a container, you first need to install Docker. The installation steps to be taken depend on the operating system of your computer, as follows:

#### Linux ####

The way to install Docker varies depending on the Linux distribution on your computer. You can find specific installation instructions for your distribution here: _[Docker Installation](https://docs.docker.com/installation/ "Docker Installation")_.

#### Windows ####

Because Docker relies on Linux-specific features, you can’t install it and run it natively in Windows. One approach is to install the _[Docker Toolbox](https://www.docker.com/toolbox "Docker Toolbox")_ application which sets up a specific Docker environment on your computer. 

Launch a Docker Toolbox _terminal_ by double-clicking the “Docker Quickstart Terminal” icon on your Desktop. If the system displays a User Account Control prompt to allow VirtualBox to make changes to your computer, choose Yes.  
The terminal does several things to set up Docker Toolbox for you. When it is done, the terminal displays the **`$`** prompt where you can type bash commands; the terminal runs a special _bash_ environment instead of the standard Windows command prompt, since the bash environment is required by Docker.

More information about installing Docker and working with containers can be found here: _[Get Started with Docker for Windows](http://docs.docker.com/windows/started/ "Get Started with Docker for Windows")_.

#### Mac OS X ####

Because Docker relies on Linux-specific features, you can’t install it and run it natively in OS X. One approach is to install the _[Docker Toolbox](https://www.docker.com/toolbox "Docker Toolbox")_ application which sets up a specific Docker environment on your computer.

Launch a Docker Toolbox _terminal_ by clicking the “Docker Quickstart Terminal” icon from the Launchpad. The terminal does several things to set up Docker Toolbox for you. When it is done, the terminal displays the **`$`** prompt where you can type _bash_ commands; the terminal runs a special bash environment instead of the standard Windows command prompt, since the bash environment is required by Docker.

More information about installing Docker and working with containers can be found here: _[Get Started with Docker for Mac OS X](http://docs.docker.com/mac/started/ "Get Started with Docker for Mac OS X")_.

### Building and running the Plone-Daviz container ###

There are two ways of building and running a Docker container using the terminal:  
- by issuing the `docker` command and manually specifying configuration parameters of the container at the terminal prompt (parameters such as the name of the container, ports to be used for accessing the container etc.);  
- by issuing the `docker-compose` command which automatically reads the configuration parameters of the container from an existing configuration file (e.g.: the “docker-compose.yml” file).

A good practice is to use the `docker-compose` command. Given the fact that, for now, the Docker Toolbox version for Windows does not support this command, the `docker` command can be used instead.

First of all, issue the following command (without the “$”):

**$** `git clone https://github.com/eea/eea.docker.daviz.git`

This will create a folder named “eea.docker.daviz” which contains the necessary files to build and run the Plone-Daviz container (e.g. “docker-compose.yml”). This folder will be your _repository directory_ from which you launch specific Docker commands. To navigate inside this folder, run this:

**$** `cd eea.docker.daviz/`

#### Using the **`docker-compose`** command (Linux and Mac OS X) ####

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

#### Using the **`docker`** command (Windows) ####

Using the Docker Toolbox terminal, while located in your repository directory, issue the following command (without the “$”):

**$** `docker run -p 80:8080 --name plone_daviz_container eeacms/daviz`

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

### Accessing the Plone-Daviz instance from your web browser ###

#### Linux ####

As long as the Plone-Daviz container is in the “started” state, you are able to access the Plone instance from the web browser. To do that, enter “localhost” or “127.0.0.1” in the address bar of the browser. Alternatively, you can type "http://localhost:80" or "http://127.0.0.1:80". After pressing Enter, the Plone start page should be displayed. Again, note that this works as long as the container is _started_.

#### Windows and OS X ####

In order to access the Plone-Daviz instance using the web browser, you first need to identify the IP address of the Docker environment on your computer. Issue the following command to accomplish this:

**$** `echo $DOCKER_HOST`

This should display an address which has the following format: “protocol://**ip\_address**:port” (for example “tcp://192.168.99.100:2376”). Open a web browser and enter the IP address (only **ip\_address**) in the address bar of the browser. Alternatively, you can type "http://**ip\_address**:80". After pressing Enter, the Plone start page should be displayed on your browser. Note that this works as long as the Plone-Daviz container (named “plone\_daviz\_container”) is in a running state.
Note: in Windows, if you are using the Internet Explorer browser and after entering the IP address in the address bar the Plone start page does not show, you might try using another web browser (e.g. Google Chrome).

### Creating the Plone site ###

Once you have the Plone start page displayed on your browser, click the “Create a new Plone site” button. You are prompted to authenticate in order to proceed further. Type _admin_ for both User Name and Password.

Next, you are presented with a page in which you can set up several options for your site:  
- the ID of the site, which will end up as part of the site's address/URL;  
- the Title of the site, which will be shown in the title of the browser window on each page;  
- the main Language of the site;  
- the Add-ons you want to activate for you site. Here, make sure that you check the box next to “**EEA Daviz**”.

Once you click the “Create Plone Site” button, you are presented with the default page of your site. Now you can perform changes and start using the EEA Daviz feature. To learn how to use it, navigate here: [EEA Daviz](http://eea.github.io/docs/IT-systems/eea.daviz/ "EEA Daviz").

