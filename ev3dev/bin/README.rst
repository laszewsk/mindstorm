Gregor's ev3dev Startup for OSX
======================================================================

Send improvements to: laszewski@gmail.com

Connecting to bluetooth
----------------------------------------------------------------------

For some reason conecting via bluetooth is not as straight
forward. Often I find myself in the situation where I have to remove
the bloototh device on the brick and the computer and start from
scratch. I often spend more time trying to connect than to actual
program. Therefore I have ordered the standard wifi dongle and hopw
with that the situation will improve. I have opted not to purchase the
Edimax version, but the regular netgear one, so i can also use it in
the standrad mindstorm environment.

Notation
----------------------------------------------------------------------

lines starting with `brick>` are executed on the brick terminal. Lines
starting with `compu>` are executed on your computer.

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

Lets create a normal user, replace gregor with the username you wnat::

     brick> adduser gregor	
     brick> usermod -a -G sudo,ev3dev,plugdev,audio,video,input,bluetooth,i2c gregor
     
Now let us place the public key on the brick, note that we execute
thes commands on our main computer. (In future I hope I have time for
all of the above steps to create a single script that you can execute
on your computer, I did not yet have time to do so.)

To setup a nice abbreviation for you ssh logins. Edit the file on your
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
   brick> apt-get install ipython-noxtebook
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

It is also possible to use your local emacs to edit files on the
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






