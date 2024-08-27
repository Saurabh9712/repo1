pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    parameters {
        string(name: 'Env', defaultValue: 'test', description: 'platform to deploy')
        booleanParam(name: 'execute test', defaultValue: true, description: 'running test cases')
        choice(name: 'AppVersion', choices: ['1.1', '1.2', '1.3'], description: 'pick any one')
}

    stages {
        stage('Compile') {
            steps {
               echo "compiling the code ${params.AppVersion}"
            }
        }
        stage('UnitTest') {
            when {
                expression {
                    params.executeTest==true
                }
            }
            steps {
               echo "Test the code" 
            }
            
        }
        stage('Package') {
            steps {
               echo "Package the code ${params.Env}"
            }
        
        stage('Deploy') {
            input {
                message "select the platform to deploy"
                ok "version selected"
                parameters {
                    choice(name: 'Platform',choices: ['EKS','ON-prem K8s','Infra Server'])
                }
            }

        
            steps {
               echo "deploy the code ${params.Env}"
            }
        }
    }
}
