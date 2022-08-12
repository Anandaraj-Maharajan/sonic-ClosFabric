pipeline{
	agent any
	stages{
		stage('Test'){
  			steps{
			 	sh 'ansible --version'
				}	
		}
		stage('invoke playbook'){
      			steps{
				ansiblePlaybook credentialsId: 'ansibleserver', installation: 'ansible296', inventory: '/home/ansible/sonic-ClosFabric/inventory.yaml', playbook: '/home/ansible/sonic-ClosFabric/fabric-bringup.yaml'
				}
   			}
		}
	}