pipeline {
agent any


environment {
TF_WORKING_DIR = 'terraform'
AWS_REGION = 'us-west-1' // Northern California
}


stages {
stage('Checkout') {
steps {
checkout scm
}
}


stage('Terraform Init & Apply') {
steps {
// Usa l'immagine ufficiale di Terraform per eseguire i comandi.
docker.image('hashicorp/terraform:1.5.0').inside('-u 0') {
dir(env.TF_WORKING_DIR) {
// se stai montando ~/.aws nel container Jenkins, terraform user avrà accesso alle credenziali
sh 'terraform init -input=false'
sh 'terraform plan -input=false -out=tfplan'
// ATTENZIONE: apply automatico. Puoi cambiare per usare approvazione manuale se preferisci.
sh 'terraform apply -input=false -auto-approve tfplan'
}
}
}
}
}


post {
failure {
echo 'Pipeline fallita.'
}
success {
echo 'Terraform apply completato.'
}
}
}
