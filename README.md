Terraform and Ansible Integration
=========

Integrating Terraform infrastructure provisioning and Ansible configuration management for end-to-end automation.

Requirements
------------

Automate the deployment of MediaWiki using steps https://www.mediawiki.org/wiki/Manual:Running_MediaWiki_on_Red_Hat_Linux#Final_comments

Solution
--------------
This solution provisions instances using Terraform.

    - Uses RHEL 8 AMI
    - Create AWS key pair
    - Create AWS security group
    - Create EC2 instance with remote-exec and local-exec provisioner triggering Ansible


Pre-requisites
-------------

- Create new ssh key or use existing ssh key which is used to connect to instance created by terraform.

  By default ssh key file names and path is: ~/.ssh/id_rsa

  Variables can be changed by adding variable values in  terraform.tfvars.
    - pub_key_file: "<SSH PUB KEY FILE PATH>"
    - prv_key_file: "<SSH PRIVATE KEY FILE PATH>"


- Can change instance count. By default its 1.
    - instance_count: 2

- Default region is us-west-2

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      become: yes
      roles:
         - role: mediawiki
