#!groovy

def COLOR_MAP = ['SUCCESS': '#008000', 'FAILURE': '#ff1744', 'UNSTABLE': '#ffc300', 'ABORTED': '#bebebe']
def getBuildUser() {
    if(currentBuild.rawBuild.getCause(Cause.UserIdCause)!=null)
        return currentBuild.rawBuild.getCause(Cause.UserIdCause).getUserId()
    else
        return null
}

pipeline {
    agent { label 'master'}

    environment{
        BUILD_USER = ''
    }
    parameters{
        choice( name: 'subscription_id', choices: ['sukriti-subs', 'shivam-subs', 'Ashish-subs'], description: 'Select the subscription')
        string( name: 'rg_name', defaultValue: '', description: 'Enter resource group name')
        string( name: 'rg_location', defaultValue: '', description: 'Enter location')
        string( name: 'cluster_name', defaultValue: '', description: 'Enter unique name for cluster')
        string( name: 'dns_prefix', defaultValue: '', description: 'Enter unique name for dns prefix')
        string( name: 'node_count', defaultValue: '3', description: 'Enter node count for AKS cluster')
        choice( name: 'vm_size', choices: [ 'Standard_DS1_v2','Standard_D2_v2', 'Standard_D2S_v2', 'Standard_B2s', 'Standard_B2ms'], description: 'Enter size for AKS nodes')
        string( name: 'environment', defaultValue: '', description: 'Add the type of environment')
        choice( name: 'Create', choices: ['True','False', 'None'], 'Tf infa to be created or destroyed or none')
    }
    stages{
        stage('Git Checkout'){
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github-creds', url: 'https://github.com/snaruto7/terraform-aks-setup.git']]])
            }
        }
        stage('Update Variables in Tfvars file'){
            steps{
                script{
                    withCredentials([azureServicePrincipal("${subscription_id}")]){
                        sh '''
                            sed -ie "s|ENV|$environment|g" terraform/terraform.tfvars
                            sed -ie "s|SUBS_ID|$AZURE_SUBSCRIPTION_ID|g" terraform/terraform.tfvars
                            sed -ie "s|CLIENT_ID|$AZURE_CLIENT_ID|g" terraform/terraform.tfvars
                            sed -ie "s|CLIENT_SECRET|$AZURE_CLIENT_SECRET|g" terraform/terraform.tfvars
                            sed -ie "s|TENANT_ID|$AZURE_TENANT_ID|g" terraform/terraform.tfvars
                            sed -ie "s|RG_NAME|$rg_name|g" terraform/terraform.tfvars
                            sed -ie "s|LOCATION|$rg_location|g" terraform/terraform.tfvars
                            sed -ie "s|CLUSTER_NAME|$cluster_name|g" terraform/terraform.tfvars
                            sed -ie "s|DNS_PREFIX|$dns_prefix|g" terraform/terraform.tfvars
                            sed -ie "s|NODE_COUNT|$node_count|g" terraform/terraform.tfvars
                            sed -ie "s|VM_SIZE|$vm_size|g" terraform/terraform.tfvars
                        '''
                    }
                }
            }
        }
        stage('Add backend for terraform'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'access-key', variable: 'key'), string(credentialsId: 'storage_acc_name', variable: 'storage_acc_name'), string(credentialsId: 'container_name', variable: 'container_name')]) {
                        sh '''
                            sed -ie "s|ACCESS_KEY|${key}|g" terraform/load-remote-state.tf
                            sed -ie "s|STORAGE_ACC_NAME|${storage_acc_name}|g" terraform/load-remote-state.tf
                            sed -ie "s|CONTAINER_NAME|${container_name}|g" terraform/load-remote-state.tf

                            sed -ie "s|ACCESS_KEY|${key}|g" terraform/config.tf
                            sed -ie "s|STORAGE_ACC_NAME|${storage_acc_name}|g" terraform/config.tf
                            sed -ie "s|CONTAINER_NAME|${container_name}|g" terraform/config.tf
                        '''
                    }
                }
            }
        }
        stage('Make tf code pretty'){
            steps{
                dir('terraform'){
                    sh ''' 
                        terraform fmt
                        terraform init
                    '''
                }
            }
        }
        stage('Plan Infra'){
            when {
                expression { params.Create == 'None'}
            }
            steps {
                dir('terraform'){
                    sh 'terraform plan'
                }
            }
        }
        stage('Create Infra'){
            when {
                expression { params.Create == 'True'}
            }
            steps {
                dir('terraform'){
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Destroy Infra'){
            when {
                expression { params.Create == 'False'}
            }
            steps {
                dir('terraform'){
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
    post{
        always{
            script {
                BUILD_USER = getBuildUser()
            }
            slackSend channel: '#terraform', 
            color: COLOR_MAP[currentBuild.currentResult],
            message: "*${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} by ${BUILD_USER}\n More info at: ${env.BUILD_URL}" 
            
            cleanWs()
        }
    }
}