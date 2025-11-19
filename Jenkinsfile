pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-west-1'   // cambiala se serve
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-credentials-id', region: env.AWS_DEFAULT_REGION) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-credentials-id', region: env.AWS_DEFAULT_REGION) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Approval') {                     // opzionale ma fortemente consigliato in prod
            when {                input message: "Vuoi applicare il plan?", ok: "Apply"
                steps {
                    echo "Approvato"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-credentials-id', region: env.AWS_DEFAULT_REGION) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
