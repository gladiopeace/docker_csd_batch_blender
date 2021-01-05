FROM amazonlinux:latest
RUN yum -y update
RUN yum -y install sudo
RUN yum -y install wget
RUN yum -y install python3 && alias python='python3'
RUN python3 -m pip install boto3
RUN python3 -m pip install clique
RUN yum -y install which unzip aws-cli
RUN amazon-linux-extras install 
RUN python3 -m pip install PyMySQL
RUN yum -y install tar
RUN yum -y install bzip2

#get the dependencies for the script
RUN mkdir -p /local/
RUN python3 -m pip install requests pathlib

#get the blender 2.81a and setup the paths
RUN cd /tmp && wget -q https://mirror.clarkson.edu/blender/release/Blender2.81/blender-2.81a-linux-glibc217-x86_64.tar.bz2 
RUN tar xf /tmp/blender-2.81a-linux-glibc217-x86_64.tar.bz2 -C /usr/bin/
RUN rm -r /tmp/blender-2.81a-linux-glibc217-x86_64.tar.bz2

#copy the shared lib for blender
RUN cp /usr/bin/blender-2.81a-linux-glibc217-x86_64/lib/lib* /usr/local/lib/ && ldconfig


ADD updateBin.py /updateBin.py
ADD csd_s3.py /csd_s3.py
ADD debug.py /debug.py
ADD csd_EC2_run.py /csd_EC2_run.py
ADD updateBin.py /usr/local/sbin/updateBin.py
ADD csd_s3.py /usr/local/sbin/csd_s3.py
ADD debug.py /usr/local/sbin/debug.py
ADD csd_EC2_run.py /usr/local/sbin/csd_EC2_run.py      

# Entry point for dis.co
WORKDIR /local/
ENTRYPOINT ["python", "-u"]
    
