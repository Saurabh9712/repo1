pipeline {
    agent any

    tools {
        maven "mymaven"
    }

    parameters {
        string(name: 'Env', defaultValue: 'test', description: 'platform to deploy')
        booleanParam(name: 'executeTest', defaultValue: true, description: 'running test cases')
        choice(name: 'AppVersion', choices: ['1.1', '1.2', '1.3'], description: 'pick any one')
    }

    stages {
        stage('Compile') {
            steps {
               echo "Compiling the code ${params.AppVersion}"
            }
        }
        
        stage('UnitTest') {
            when {
                expression {
                    params.executeTest == true
                }
            }
            steps {
               echo "Running tests"
            }
        }
        
        stage('Package') {
            steps {
               echo "Packaging the code for environment: ${params.Env}"
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
               echo "Deploying the code to ${params.Platform} environment"
            }
        }
    }
}

