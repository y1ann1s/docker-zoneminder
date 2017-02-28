# docker-zoneminder

Docker container for [zoneminder v1.30.1][3]

"ZoneMinder the top Linux video camera security and surveillance solution. ZoneMinder is intended for use in single or multi-camera video security applications, including commercial or home CCTV, theft prevention and child, family member or home monitoring and other domestic care scenarios such as nanny cam installations. It supports capture, analysis, recording, and monitoring of video data coming from one or more video or network cameras attached to a Linux system. ZoneMinder also support web and semi-automatic control of Pan/Tilt/Zoom cameras using a variety of protocols. It is suitable for use as a DIY home video security system and for commercial or professional video security and surveillance. It can also be integrated into a home automation system via X.10 or other protocols. If you're looking for a low cost CCTV system or a more flexible alternative to cheap DVR systems then why not give ZoneMinder a try?"

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 16.04 use the commands:

    $ sudo apt-get update
    $ wget -qO- https://get.docker.com/ | sh

 To install docker in other operating systems check [docker online documentation][4]

## Usage

To run container use the command below:

    $ docker run -d --shm-size=4096m -p 80 quantumobject/docker-zoneminder

**  --shm-size=4096m  ==> work only after docker version 1.10 

## Accessing the Zoneminder applications:

After that check with your browser at addresses plus the port assigned by docker:

  - **http://host_ip:port/zm/**

Them log in with login/password : admin/admin , Please change password right away and check on-line [documentation][6] to configure zoneminder.

note: ffmpeg was added and path for it is /usr/local/bin/ffmpeg  if needed for configuration at options .

For live view via the web UI to work, you need to edit config -> paths, and change:

"/cgi-bin/nph-zms"     to     "/zm/cgi-bin/nph-zms"

and if you change System=> "Authenticate user logins to ZoneMinder" you at this moment need to change "Method used to relay authentication information " to "None" if this not done you will be unable to see live view. This only recommended if you are using https to protect password(This relate to a misconfiguration or problem with this container still trying to find a better solutions).

if timeline fail please check TimeZone at php.ini is the correct one for your server( default is America/New York).

To access the container from the server that the container is running :

    $ docker exec -it container_id /bin/bash

## More Info

About zoneminder [www.zoneminder.com][1]

To help improve this container [quantumobject/docker-zoneminder][5]

For additional info about us and our projects check our site [www.quantumobject.org][7]

[1]:http://www.zoneminder.com/
[2]:https://www.docker.com
[3]:http://www.zoneminder.com/downloads
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-zoneminder
[6]:http://www.zoneminder.com/wiki/index.php/Documentation
[7]:https://www.quantumobject.org
