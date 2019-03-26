# encoding: utf-8

# copyright: Nah buddy, not here.

title 'AKS Validator'

control '01-rg-exists' do
  impact 1.0
  title 'AKS Resource Group Check'
  desc 'Checks that the resoruce group specified exists'
  describe azurerm_resource_groups do
    its('names') { should include attribute('resource_group') }
  end
end

control '02-aks-in-correct-rg' do
  impact 0.7
  title 'AKS Cluster existance check'
  desc 'Checks that the AKS cluster exists in the correct resource group'
  describe azurerm_aks_cluster(resource_group: attribute('resource_group'), name: attribute('cluster_name')) do
    it { should exist }
  end
end

control '03-aks-provisioned' do
  impact 1.0
  title 'AKS Cluster provisioning check'
  desc 'Tests to see that the AKS cluster has been provisioned successfully'
  describe azurerm_aks_cluster(resource_group: attribute('resource_group'), name: attribute('cluster_name')) do
    its('properties.provisioningState') { should cmp 'Succeeded' }
  end
end

control '04-aks-node-count' do
  impact 1.0
  title 'AKS Worker Node Check'
  desc 'Checks to see that the Worker node count is correct'
  describe azurerm_aks_cluster(resource_group: attribute('resource_group'), name: attribute('cluster_name')) do
    its('properties.agentPoolProfiles.first.count') { should eq attribute('worker_count') }
  end
end

control '05-aks-dnsprefix' do
  impact 1.0
  title 'AKS DNS Prefix check'
  desc 'Checks that the DNS prefix matches the supplied'
  describe azurerm_aks_cluster(resource_group: attribute('resource_group'), name: attribute('cluster_name')) do
    its('properties.dnsPrefix') { should eq attribute('dns_prefix') }
  end
end

control '06-aks-worker-size' do
  impact 1.0
  title 'AKS Worker Size Check'
  desc 'checks to make sure that the size of the worker is correct'
  describe azurerm_aks_cluster(resource_group: attribute('resource_group'), name: attribute('cluster_name')) do
    its('properties.agentPoolProfiles.first.vmSize') { should cmp attribute('worker_size') }
  end
end

control '07-aks-kube-version' do
  impact 1.0
  title 'AKS K8s Version Check'
  desc 'checks to make sure that the version of K8s deployed is correct'
  describe azurerm_aks_cluster(resource_group: attribute('resource_group'), name: attribute('cluster_name')) do
    its('properties.kubernetesVersion') { should cmp attribute('kube_version') }
  end
end
