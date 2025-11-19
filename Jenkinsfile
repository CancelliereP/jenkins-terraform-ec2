pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'eu-west-3'  // cambia con la tua regione se vuoi
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: env.AWS_CREDENTIALS_ID, region: env.AWS_DEFAULT_REGION) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: env.AWS_CREDENTIALS_ID, region: env.AWS_DEFAULT_REGION) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        // Stage di approvazione manuale (corretto!)
        stage('Approval') {
            when {
                // mostra questo stage solo su branch main (o cambia con il tuo)
                branch 'main'
            }
            steps {
                input message: 'Vuoi applicare il Terraform plan?',
                      ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: env.AWS_CREDENTIALS_ID, region: env.AWS_DEFAULT_REGION) {
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

