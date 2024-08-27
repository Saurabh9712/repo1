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

    stages {
        stage('Compile') {
            steps {
                script {
                    echo "Compiling the code ${params.AppVersion}"
                    sh 'mvn compile'
                }
            }
        }
        
        stage('UnitTest') {
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
            steps {
                script {
                    echo "Packaging the code for environment: ${params.Env}"
                    sh 'mvn package'
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

