=============================
ka-lite-zim
=============================

.. image:: https://travis-ci.org/benjaoming/ka-lite-zim.png?branch=master
    :target: https://travis-ci.org/benjaoming/ka-lite-zim

.. image:: https://readthedocs.org/projects/ka-lite-zim/badge/?version=latest
    :target: http://ka-lite-zim.readthedocs.org/en/latest/


OpenZIM export command for ka-lite.


Quick Start
-----------


You should use our docker : openzim/kalite. (Without docker see at end of README.rst)
::
  docker run -v [your folder here]:/data openzim/kalite kalite manage export2zim /data/[zim name].zim [--language=[code lang]] --tmp-dir=/data/[tmp folder name] --download

For exemple :
::
  docker run -v /tmp:/data openzim/kalite kalite manage export2zim /data/ka-fr.zim --language=fr --tmp-dir=/data/ka-lite-zim_fr --download


IMPORTANT WHEN USING --language :
Language are not automatically download.
You should download them :
::
	$ kalite manage setup  #configure with whatever, BUT download assesssment items package
	$ kalite manage languagepackdownload -lfr --commandline #change -lfr (french) with your codelang (-l<code lang>) (see below for code lang)

And after than you can lauch kalite manage export2zim with your options
You can found [code lang] here in the tab : `List of languages <https://ka-lite.readthedocs.io/en/latest/faq.html#how-can-i-install-a-language-pack-without-a-reliable-internet-connection>`

Your zim will be at : [your folder here]/[zim name].zim

Interact with kalite
--------------------
If you run docker interactively with "-ti":
  you can launch export script with ``kalite manage export2zim``

  Don't forget ``--download`` options if you haven't video in your ``~/.kalite`` cache

  Usage is available at ``kalite manage help export2zim``

  **Beware!** Despite what usage/help says, the proper parameter order is ``zim_file`` first then options. Example: ``kalite manage export2zim ka-fr.zim --language=fr``


Features
--------

* Exporting the contents of a local `KA Lite <https://learningequality.org/ka-lite/>`_ installation to the `OpenZim <http://www.openzim.org/>`_
* Easy to customize since you use KA Lite to select and download videos
* Creates a .zim file with a single-page webapp containing video player and simple JS-based UI for filtering and searching the videos


Use case and contributions
--------------------------

This project is a Python project but is NOT on PyPi because it's not intended
for a wider audience. So just get the latest master, it should work with the
latest KA Lite release. Please contribute to this project if you have changes to the .zim files that
are available on the `Kiwix website <http://www.kiwix.org/wiki/Content_in_all_languages>`_

The goal of this command is to build an alternative use case of Khan Academy for
the popular offline reader Kiwix, which works for the open standards format
OpenZim. Thus, it can benefit from the data prepared through the KA Lite
software.

While KA Lite is truly built for education, Kiwix is more of an eLibrary. While
Kiwix and OpenZim is more static, KA Lite has its focus on interaction.


Future
------

The export command for KA Lite is the immediate and easiest target. But we hope
to be able to understand the OpenZIM format well enough to build an import
command as well such that KA Lite students can interact with the data packaged
and distributed by zim-packagers.

Without docker
--------------
You can also use virtualenv but it's harder...because current code base is tied to version 0.15.1 of KA-Lite which fails to install from non-prehistoric pip, so we use prehistoric pip in virtualenv.

::

    virtualenv -p /usr/bin/python2.7 kalite-env
    source kalite-env/bin/activate

    mkdir -p ~/.kalite
    echo "from kalite.project.settings.base import *" >> ~/.kalite/settings.py
    echo "INSTALLED_APPS += ['kalite_zim', 'compressor',]\n" >> ~/.kalite/settings.py
    pip install django>=1.5,<1.6
    pip install pip==7.0.0
    pip install setuptools==12.0
    pip install ka-lite==0.15
    pip install ka-lite-zim

**Note**: if using the Docker ``zimwriterfs``, make sure to work off the same absolute path of your docker volume (/data for example) for symlinks can be resolved.
See "Interact with kalite" section for how using it.

::

	ln -s /data/ /home/user/kalite
	kalite manage export2zim /data/ka-fr.zim --language=fr --tmp-dir=/data/ka-lite-zim_fr
	docker run --name zimwriterfs -v /data:/data openzim/zimwriterfs zimwriterfs XXX



