## About Chef

Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each Chef organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by Chef. Cookbooks (and recipes) are used to tell Chef how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration.

Overview of Chef at :

http://docs.opscode.com/chef_overview.html

More info at:

http://docs.opscode.com/

## About Knife

Knife is a command-line tool that provides an interface between a local Chef repository and the Chef Server. Knife helps users of Chef to manage:

* Nodes
* Cookbooks and recipes
* Roles
* Stores of JSON data (data bags), including encrypted data
* Environments
* Cloud resources, including provisioning
* The installation of Chef on management workstations
* Searching of indexed data on the Chef Server

More info at:

http://docs.opscode.com/knife.html

## chef-client

A chef-client is an agent that runs locally on every node that is registered with the Chef Server. When a chef-client is run, it will perform all of the steps that are required to bring the node into the expected state, including:

Registering and authenticating the node with the Chef Server
Building the node object
Synchronizing cookbooks
Compiling the resource collection by loading each of the required cookbooks, including recipes, attributes, and all other dependencies
Taking the appropriate and required actions to configure the node
Looking for exceptions and notifications, handling each as required

## Commands Quick Reference

### From Workstation

#### Chef Environment

We have two organisations in our Opscode Chef Server account. The organisations are:

* chro - used for production
* ivin-staging - used for testing

When you are working (or uploading) code related to testing environment (such as standby server), prepend all the commands from the workstation with ```CHEF_ENV='staging'``` to target the ivin-staging organisation. 
For ex., to upload a cookbook to the server targeting ivin-staging, use the following command

```CHEF_ENV='staging' knife cookbook upload <cookbook-name>```

By default (i.e. in the absence of CHEF_ENV variable), all changes are sent to chro organisation.

Action|Command
------|-------
Upload cookbook to Chef Server|```knife cookbook upload <cookbook-name>```
Upload environment to Chef Server|```knife environment from file <file>```
Upload role to Chef Server|```knife role from file <path-to-file>```

#### Booting new servers

Run the following commands to boot up a new server. The command must be run from the root of the Chef Repo in your workstation

##### Staging

```CHEF_ENV='staging' knife ec2 server create -I ami-0b9c9f62 -f m2.xlarge -r "role[ivin_common],role[ivin_only_common],role[db_client],role[app_server],role[web_server],role[ivin_cron]" -G staging,chef,default -E staging -S "ivin_dev_keypair" --ssh-user ubuntu --no-host-key-verify --ebs-size 40 -Z us-east-1c```

##### Production

```knife ec2 server create -I ami-0b9c9f62 -f m2.xlarge -r "role[ivin_common],role[ivin_only_common],role[db_client],role[app_server],role[web_server],role[ivin_cron]" -G production,chef,default -E production -S "ivin_dev_keypair" --ssh-user ubuntu --no-host-key-verify --ebs-size 40 -Z us-east-1c```

##### Standby

```CHEF_ENV='staging' knife ec2 server create -I ami-0b9c9f62 -f m2.xlarge -r "role[ivin_common],role[ivin_only_common],role[db],role[app_server],role[web_server],role[ivin_cron]" -G standby,chef,default -E standby -S "ivin_dev_keypair" --ssh-user ubuntu --no-host-key-verify --ebs-size 40 -Z us-east-1c```


### From Node

Action|Command
------|-------
Synchronise cookbooks with the chef server|```sudo chef-client```
