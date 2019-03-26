# AKS Cluster Validation Example

This example shows how to use Inspec to check the state of a deployed AKS cluster. At present this is only checking the following validations:

* <b>01-rg-exists</b> - Checks that the resource group specified exists

* <b> 02-aks-in-correct-rg </b> - Checks that the AKS cluster exists in the correct resource group

* <b> 03-aks-provisioned </b> - Tests to see that the AKS cluster has been provisioned successfully

* <b> 04-aks-node-count </b> - Checks to see that the Worker node count is correct

* <b> 05-aks-dnsprefix </b> - Checks that the DNS prefix matches the supplied

* <b> 06-aks-worker-size </b> - Checks to make sure that the size of the worker is correct

* <b> 07-aks-kube-version </b> - Checks to make sure that the version of K8s deployed is correct

This profile relies on an attributes file being passed in with the correct values you need to validate. An example of this file is :   

```  
cluster_name: My-Demo-Cluster
resource_group: My-Demo-ResourceGroup
dns_prefix: DEM   
worker_count: 5     
worker_size: Standard_A1_v2  
kube_version: 1.11.8
```

We also need the Azure credentials set up (either in a creds file, or with environment variables. See [Inspec Documentation](https://www.inspec.io/docs/reference/platforms/) for instructions)
   

To run this, use the following command (assuming you have cloned this repo and are in the directory):  
`inspec exec . -t azure:// --attrs /path/to/my_profile_attributes.yml`