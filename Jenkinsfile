pipeline
{
    options
    {
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    agent any
    environment 
    {
        VERSION = "latest"
        REPO_PREFIX = "3dna"
        PROJECT = "python-lambda-builder"
        REPO = "$REPO_PREFIX/$PROJECT"
        REGION = "us-east-1"
        ECRURI = "1234567890.dkr.ecr.us-east-1.amazonaws.com"
    }
    stages
    {
        stage('Build preparations')
        {
            steps
            {
                script 
                {
                    // calculate GIT lastest commit short-hash
                    gitCommitHash = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                    // calculate a sample version tag
                    VERSION = gitCommitHash.take(7)
                    // set the build display name
                    currentBuild.displayName = "#${BUILD_ID}-${VERSION}"
                }
            }
        }
        stage('Docker build')
        {
            steps
            {
                script
                {
                    // Build the docker image using a Dockerfile
                    sh "docker build -t $REPO:latest -t $ECRURI/$REPO:latest -t $ECRURI/$REPO:$VERSION ."
                }
            }
        }
        stage('Docker push')
        {
            steps
            {
                script
                {
                    // push images to ECR
                    sh "docker push $ECRURI/$REPO:latest"
                    sh "docker push $ECRURI/$REPO:$VERSION"
                }
            }
        }
    }
    
    post
    {
        always
        {
            // make sure that the Docker image is removed
            sh "docker rmi -f \$(docker images --format '{{.Repository}}:{{.Tag}}' | grep $REPO)"
        }
    }
} 
