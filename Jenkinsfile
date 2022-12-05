pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="129676970375"
        AWS_DEFAULT_REGION="us-east-1"
        IMAGE_REPO="gatling"
        TAG="gatling-runner"
        AWS_REPORT_BUCKET="gatlingbkt"
        PROFILE="EcrRegistryFullAccessEC2"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO}"
    }

    stages {

        // Building Docker image
        stage('Buil Docker Image') {
          steps{
            script {
             //sh "chmod +x build_image.sh"
             //sh "./build_image.sh -i ${IMAGE_REPO} -c ${TAG}."
              dockerImage = docker.build "${IMAGE_REPO}:${TAG}"
            }
          }
        }

        // Run Docker Container
        stage('Run Docker Container') {
             steps{
                 script {
                  sh "chmod +x run_container.sh"
                  sh "./run_container.sh -c ${IMAGE_REPO}"
                 }
             }
        }

         // Run Gatling Test
        stage('Run Gatling Test') {
             steps{
                 script {
                  sh "chmod +x runTest"
                  sh "./runTest.sh -i ${IMAGE_REPO} -c ${TAG}"
                 }
             }
        }

        /* Logging to AWS ECR
         stage('Logging into AWS ECR') {
            steps {
                script {
                sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
            }
         }

         // Uploading Docker images into AWS ECR
         stage('Pushing to ECR') {
                steps{
                    script {
                           sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                           sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                    }
                }
         }*/

    }

}
