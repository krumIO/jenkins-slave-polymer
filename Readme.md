Link to GitHub: [https://github.com/krumIO/jenkins-slave-polymer](https://github.com/krumIO/jenkins-slave-polymer)
Link to Dockerhub: [https://store.docker.com/community/images/krumware/jenkins-slave-polymer](https://store.docker.com/community/images/krumware/jenkins-slave-polymer)

# Jenkins swarm slave preconfigured for Polymer-CLI

This image is a preconfigured openjdk instance which can auto-allocate and de-allocate itself as a node with a master Jenkins instance.  Additional reading on how the Swarm Plugin works in general can be found in the resources section below.

You can use this image to run a node used with a typical pipeline file, no extra volume/workspace share magic here.

Pre-installed:
 - NodeJS 8
 - NPM 4
 - Bower
 - Gulp 4 (with cli)
 - Polymer-CLI (latest)
 - Chrome (latest)
 - Firefox (extended support version)
 - OpenJDK
 - XVFB

Not yet installed:

This image requires a Jenkins instance with [Swarm Plugin](https://wiki.jenkins.io/display/JENKINS/Swarm+Plugin) installed.

Resources
 - Swarm Plugin documentation: [https://wiki.jenkins.io/display/JENKINS/Swarm+Plugin](https://wiki.jenkins.io/display/JENKINS/Swarm+Plugin)
 - Base swarm slave image (thanks to [Carlos Sanchez](https://github.com/carlossg) for maintaining!) :
    - Github: [carlossg/jenkins-swarm-slave-docker](https://github.com/carlossg/jenkins-swarm-slave-docker)
    - Dockerhub: [csanchez/jenkins-swarm-slave](https://store.docker.com/community/images/csanchez/jenkins-swarm-slave/)

## Running

To run a Docker container passing [any parameters](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin#SwarmPlugin-AvailableOptions) to the slave

It is recommended that a label be specified for ease of selection in your pipeline.
jenkins:jenkins is used here for an example password combination. 

The base image attempts to connect to http://jenkins:8080 by default.

Run with direct connection to a Jenkins master not located at the default address:
 - docker run krumware/jenkins-slave-polymer -master http://other-jenkins:8080 **-username** jenkins **-password** jenkins **-executors** 1 **-labels** polymer

Run in a service stack with linking to the Jenkins master container
 - docker run --link jenkins:jenkins krumware/jenkins-slave-polymer **-username** jenkins **-password** jenkins -executors 1 **-labels** polymer

## Troubleshooting
 - Currently, it looks like the base image sometimes has trouble in stack configurations where environmental variables are designated.  You can get around this by passing cmd line args as the `command`. For example: `-username jenkins -password jenkins -executors 1 -labels polymer`


# Building
    docker build -t krumware/jenkins-slave-polymer .