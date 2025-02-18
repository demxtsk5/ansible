#!/bin/bash

ansible all -m user -a "name=automation generate_ssh_key=true" -i localhost, -k
ansible all -m user -a "name=automation" -i 192.168.64.4,192.168.64.5,192.168.64.6, -k
ansible all -m file -a "path=/home/automation/.ssh state=directory owner=automation group=automation mode=0700" -i 192.168.64.4,192.168.64.5,192.168.64.6, -k
ansible all -m copy -a "src=/home/automation/.ssh/id_rsa.pub dest=/home/automation/.ssh/authorized_keys owner=automation group=automation mode=0600" -i 192.168.64.3,192.168.64.4,192.168.64.5,192.168.64.6, -k 
ansible all -m copy -a "dest=/etc/sudoers.d/automation content='automation ALL=(ALL) NOPASSWD: ALL' owner=root group=root mode=0440 validate='/usr/sbin/visudo -csf %s'" -i 192.168.64.3,192.168.64.4,192.168.64.5,192.168.64.6, -k
