pipeline {
    agent any

    tools {
        maven "mymaven"
    }

    parameters {
        string(name: 'Env', defaultValue: 'test', description: 'Platform to deploy')
        booleanParam(name: 'executeTest', defaultValue: true, description: 'Running test cases')
        choice(name: 'AppVersion', choices: ['1.1', '1.2', '1.3'], description: 'Pick any one')
    }


    environment {

        PACKAGE_SERVER='ec2-user@172.31.39.4'
    }

    stages {
        stage('Compile') {
            agent {label 'linux-slave'}
            steps {
                script {
                    echo "Compiling the code ${params.AppVersion}"
                    sh 'mvn compile'
                }
            }
        }
        
        stage('UnitTest') {
            agent any
            when {
                expression {
                    params.executeTest == true
                }
            }
            steps {
                script {
                    echo "Running tests"
                    sh 'mvn test'
                }
            }
        }
        
        stage('Package') {
            agent any
            steps {
                script {
                    sshagent(['slave2']){
                    echo "Packaging the code for environment: ${params.Env}"
                    sh "scp -o StrictHostKeyChecking=no server-config.sh ${PACKAGE_SERVER}:/home/ec2-user"
                    sh "ssh -o StrictHostKeyChecking=no ${PACKAGE_SERVER} 'bash ~/server-config.sh'"
                  
                }
                }
            }
        }
        
        stage('Deploy') {
            input {
                message "Select the platform to deploy"
                ok "Proceed with deployment"
                parameters {
                    choice(name: 'Platform', choices: ['EKS', 'ON-prem K8s', 'Infra Server'], description: 'Select the deployment platform')
                }
            }
            steps {
                script {
                    echo "Deploying the code to ${params.Env} environment"
                }
            }
        }
    }
}
