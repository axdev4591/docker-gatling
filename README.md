# Gatling setup CI and Docker

This is repo running load test with gatling docker container in AWS using a Jenkinsfile. It does following things

 * Get Gatling Setup into your Jenkins WORKSPACE

 * Docker image and containers with Gatling setup 

 * Generate report in HTML.

 * Easy to use bash scripts plauggable with Jenkins or any othe CI server 



# Usage

 Pre-requisite is to have JDK(Java) installed as scala being JVM based language.

 
## Running Gatling Test Inside Docker Containers

### Pre-defined Simulation 

*  Run container using the downloaded images 

            $ docker run -it -d --name docker-gatling-container docker-gatling 
            
*  Run default simulations inside the docker containers 

            $ docker exec docker-gatling-container /opt/gatling/bin/gatling.sh -sf /opt/gatling/user-files/simulations/ -s computerdatabase.BasicSimulation -rf /opt/gatling/results/
            
            
This will execute default simulation. 

 
## Run Gatling Test on Jenkins

* Record your load test simulations and put your class in the 'user-files/simulations'. OR You can use the pre-recorded simulation for this demo

