#Faudra update le readme aussi
#~/.kalite/settings.py
#kalite manage help export2zim



FROM openzim/zimwriterfs:latest

# Install necessary packages
RUN apt-get update -y
RUN apt-get install -y python-pip
RUN apt-get install -y ffmpeg
RUN apt-get install -y git
RUN apt-get install -y sed
RUN apt-get install -y make
RUN apt-get install -y libffi-dev

# Install sotoki
RUN locale-gen "en_US.UTF-8"

RUN pip install django>=1.5
RUN pip install pip==7.0.0
RUN pip install setuptools==12.0
RUN pip install ka-lite==0.15

RUN mkdir -p ~/.kalite
RUN echo "from kalite.project.settings.base import *" > ~/.kalite/settings.py
RUN echo "INSTALLED_APPS += ['kalite_zim', 'compressor',]" >> ~/.kalite/settings.py

RUN pip install ka-lite-zim
# Boot commands
CMD kalite manage help export2zim ; echo "Usage : kalite manage export2zim" ; /bin/bash
