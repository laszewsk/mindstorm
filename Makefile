UNAME := $(shell uname)

BROWSER=firefox
ifeq ($(UNAME), Darwin)
BROWSER=open
endif
ifeq ($(UNAME), Windows)
BROWSER=/cygdrive/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
endif
ifeq ($(UNAME), CYGWIN_NT-6.3)
BROWSER=/cygdrive/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe
endif

test:
	echo $(UNAME)


doc:
	fab doc.html

all:
	cd docs; make epub
	cd docs; make latex
	cd docs; make latexpdf
	fab doc.html
	mkdir -p docs/build/html/files
	cp docs/build/latex/Mindstorm.pdf docs/source/files/Mindstorm.pdf
	cp docs/build/epub/Mindstorm.epub docs/source/files/Mindstorm.epub

publish:
	ghp-import -n -p docs/build/html

view:
	$(BROWSER) docs/build/html/index.html


######################################################################
# CLEANING
######################################################################

clean:
	rm -rf build dist docs/build .eggs
	rm -rf *.egg-info
	find . -name "*~" -exec rm {} \;
	find . -name "*.pyc" -exec rm {} \;
	cd docs; make clean
	echo "clean done"

######################################################################
# TAGGING
######################################################################

tag:
	cm-authors > AUTHORS
	git tag
	@echo "New Tag?"; read TAG; git tag $$TAG; python setup.py install; git commit -m $$TAG --allow-empty; git push origin --tags

rmtag:
	git tag
	@echo "rm Tag?"; read TAG; git tag -d $$TAG; git push origin :refs/tags/$$TAG


