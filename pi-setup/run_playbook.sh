#!/bin/bash
ansible-playbook -i hosts site.yml
ansible-playbook -i hosts splunk-forwarder.yml
