Gregor's ev3dev iPython 
======================================================================

Send improvements to: laszewski@gmail.com

Connecting to bluetooth
----------------------------------------------------------------------

For some reason conecting via bluetooth is not as straight
forward. Often I find myself in the situation where I have to remove
the bloototh device on the brick and the computer and start from
scratch. I often spend more time trying to connect than to actual
program. I verified this seems to be an issue with OSX. Others that 
have Windows seem not to have the issue. This even happens on the 1.08H 
firmware update.

Connecting with wifi
----------------------

Starting with firmware version 1.08H also Edimax is supported. I have
both Edimax and the big Netgear N150 dongle. As botth now work, you
may just want to go with the Edimax wifi adapter as it is cheaper.
One thing to remember is that you use WPA2 and make sure you do not
use a wifi standard that is not supported by your modem and the network card. 
If your router supports multiple wifi stanards, just set up a network that is
supported by the card and use that. I use 802.11n.

Rechargable Batteries
----------------------------------------------------------------------

I have had very cheap rechargable batteries only 900mA and they were
simply discharging to fast. However the biggest issue was that the
design of the robot needs to allow for the battery box to be
accessible. I have the home kit and not the education kit and after a
while I decided it was just more practical to get the rechargeble
battery. The original recharger I got for $10 cheaper with free 
shipping. In retrospect, I should have just ordered the
education set. Its unfortunate that you can not get an add-on that
compliments the one with the other. If you are already at it I
recommend you get some other parts as ordering through the education
store results in shipping costs.

Home made Ball bearings
---------------------------------------------------------------------

I have not yet completed that project but in hardware stores you can
get ball baerings for furniture projects. The one at Harbor freights
are pretty cheap. You can enlarge the mount wholes and put some conectors
on so you can use such DIY ball bearings. I will make a phot once I
have some time.

* http://www.harborfreight.com/1-roller-ball-bearing.html ($0.89)
* http://www.harborfreight.com/5-8-roller-ball-bearing.html ($1.79)

I have only the 5/8 in bearings, but should have also bought the 1 in 
version as that is closer to the actual size of the lego metal balls.

Notation
----------------------------------------------------------------------

* Lines starting with `brick>` are executed on the brick terminal. 
* Lines starting with `compu>` are executed on your computer.

SSH keys
----------------------------------------------------------------------

As it is quite annoying to always use the password to login to the
brick it seems obvious to use ssh key authentication. So let us set up
the keys. We assume that you have set up a key on your computer with::

    ssh-keygen

We assume your key is placed in::

   ~/.ssh/id_rsa.pub

Lets first login into the brick and change the default password::

     compu> ssh root@lego

The default password is `r00tme` with two zeros in it. Once you are
logged in you can change the password with

     brick> passwd

Lets create a normal user, replace gregor with the username you want::

     brick> adduser gregor	
     brick> usermod -a -G sudo,ev3dev,plugdev,audio,video,input,bluetooth,i2c gregor
     
Now let us place the public key on the brick, note that we execute
thes commands on our main computer. (In future I hope I have time for
all of the above steps to create a single script that you can execute
on your computer.)

To setup a nice abbreviation for you ssh logins, edit the file on your
local computer `~.ssh/config`.

In that file add the following::

   Host lego
     	Hostname 192.168.2.3

Make sure the ip is correct.  Now you can use `root@lego` and
`gregor@lego` to log into your various accounts. Hence we can now
say::

    compu> ssh root@lego mkdir /root/.ssh
    compu> scp ~/.ssh/id_rsa.pub root@lego:.ssh/authorized_keys

Lets try::

     compu> ssh root@lego

If everything works fine, you will be asked for your password of the
key through the OSX keychain. once you typed it in (if you have not
already done so previously), you will be directly logged into the
brick.

Make also sure that you have the public key in the
./ssh/authorized_keys file for the user that you create.

Updating the system
----------------------------------------------------------------------

To make sure your sustem is up to date, execute the following::

   brick> dpkg-reconfigure tzdata
   brick> apt-get update
   brick> apt-get upgrade
   brick> apt-get dist-upgrade
   brick> reboot

As we want to install python for ev3dev, ipython notebook we execute::

   brick> apt-get install git
   brick> apt-get install ipython-notebook
   brick> apt-get install python-setuptools python-pil
   brick> easy_install -U python-ev3dev
   brick> pip install rpyc

Next we want o install emacs, if this is one of the editors you like
to use, if not you can skip it as other editors such as vi or vim are
already available::

    brick> apt-get remove emacs*
    brick> apt-get install emacs-nox


Using emacs to edit files from your computer on the brick
----------------------------------------------------------------------

It is also possible to use your local laptop emacs to edit files on the
brick. The way to do that is simply to specify the properlocation::

  C-x C-f /gregor@lego:filename

Setting up ipython notebook
----------------------------------------------------------------------

There are multiple ways on setting up ipython notebook. The way we do
it here is simply to use the notebook server on the brick and connect
to it from your computer and tunnel the commands via an SSH tunnel::

   compu> ssh gregor@lego ipython notebook --no-browser --port=8889
   compu> ssh -N -f -L localhost:8888:localhost:8889 gregor@lego

Now you can open the notebook with::

     compu> open localhost:8888

Note it will take some time for the server to start so be patient and
refresh the page till it works.

Too kill the tunnel find it with::

    compu> ps aux | grep localhost:8889

Find the ID and use::

     compu> kill -15 ID

where ID is the proccess ID number. Dont forget to kill the ipython
notebook on the brick with a similar approach.

Now you have kind of an interactive python environment available on
your brick using python.






