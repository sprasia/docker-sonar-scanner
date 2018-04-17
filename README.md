# docker-sonar-scanner Overview

A quick [Sonar](http://www.sonarqube.org/) scanner (command line) container.

https://hub.docker.com/r/sprasia/sonar-scanner/

This Dockerfile sets up the command line scanner vs. any other existing analysis
method. For other analysis methods, see the bottom of this page:

http://docs.sonarqube.org/display/SONAR/Analyzing+Source+Code

For details on running the command line scanner:

http://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner

and for a list of command-line options: http://docs.sonarqube.org/display/SONAR/Analysis+Parameters


# Quick Reference - tl;dr version


```
docker run -ti -v $(pwd):/root/src sprasia/sonar-scanner
```

Run this from the root of your source code directory, it'll scan everything below it.

## Long Version

Run the following command from the command line to start the scanner. This uses the default settings in the sonar-runner.properties file, which you can overload with -D commands (see below).

    docker run -ti -v $(pwd):/root/src sonarqube sprasia/sonar-scanner 

Replace "$(pwd)" with the absolute path of the top-level source directly you're interested in if you're not running the docker image from the top level project directory. It will scan everything under that directory when it starts up.

If you need to change that or any other of the variables that Scanner needs to run, you can pass them in with the command itself to override them:

    docker run -ti -v $(pwd):/root/src sprasia/sonar-scanner sonar-scanner sonar.host.url=YOURURL -Dsonar.projectBaseDir=./src

Here's a fully-loaded command line (based on latest/3.0.3 version) that basically overrides everything from the sonar-runner.properties file on the command-line itself. The settings shown here match those in the sonar-runner.properties file.

```
docker run -ti -v $(pwd):/root/src sprasia/sonarscanner sonar-scanner \
  -Dsonar.host.url=http://sonarqube:9000 \
  -Dsonar.jdbc.url=jdbc:h2:tcp://sonarqube/sonar \
  -Dsonar.projectKey=MyProjectKey \
  -Dsonar.projectName="My Project Name" \
  -Dsonar.projectVersion=1 \
  -Dsonar.projectBaseDir=/root \
  -Dsonar.sources=./src
```

Note that you can also pass parameters as JSON using the `SONARQUBE_SCANNER_PARAMS` environment variable.