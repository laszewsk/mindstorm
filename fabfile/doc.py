from fabric.api import task, local
import sys
import os
from .banner import banner

browser = "firefox"

if sys.platform == 'darwin':
    browser = "open"

debug = True    

@task
def view():
    """view the documentation in a browser"""
    local("{browser} docs/build/html/index.html".format(browser=browser))


@task
def html():
    banner("Make the sphinx documentation")
    local("cd docs; make html")

@task
def publish():
    """deploy the documentation on gh-pages"""
    banner("publish doc to github")
    local("ghp-import -n -p docs/build/html")
    #html()
    #local('cd docs/build/html && git add .  && git commit -m "site generated" && git push origin gh-pages')
    #local('git commit -a -m "build site"')
    #local("git push origin master")

