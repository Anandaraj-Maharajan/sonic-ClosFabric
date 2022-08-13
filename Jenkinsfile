pipeline{
		agent any
			stages{
					stage('Install dependencies'){
						steps{
						 	sh 'ansible --version'
						 	sh 'ansible-galaxy collection install dellemc.enterprise_sonic'
							}
						}
						stage('Unit test'){
					   		steps{
							    ansiblePlaybook credentialsId: 'ansibleserver', extras: '--diff --check', installation: 'ansible296', inventory: '/home/ansible/sonic-ClosFabric/inventory.yaml', playbook: '/home/ansible/sonic-ClosFabric/fabric-bringup.yaml'
								}
						}
						stage('Build container'){
							steps{
								sh 'docker build -t dellsonic/evpnfabric:latest .'
								}
						}
			}
}