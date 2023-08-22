## KardTest Usage Guide
This guide will walk you through the steps required to use this IaC repo

### PreReqs - I assumed using a linux based machine - also assumed debian style 

1. Terraform: Download and install latest [terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. Cloud Provider ( AWS ) account setup and IAM user
3. AwsCli configured
4. IDE to view manifests
5. Either a pregenerated ssh key - or use aws keypair

#### Getting Started

1. The root of this tree is structured by env-region; inside each there is a hierarchy delinted  numerically
2. cd into the 001-vpc and terraform init and apply
3. cd into 002-rds && terraform init and apply
4. so on and so forth
5. Destroy in reverse order on your way out 👋


#### Paradigm overview - Shoot for simple!!
> I chose to go with an oop structure in this design
> utilizing component structures the modules are all interpolated
> at root
>> Pros: Easy to maintain, scalable, flexible, logical observation \
>> Cons: Slight learning curve, Can customize at root level e.g drift 

#### Why I chose to write own mod vs import prefabricated
> Greater control at ci & release process, no unknowns introduced

#### Food for thought!!

> Having a bastion box while supportive, exposes an attack vector. 
> Even with all the best IAM policy's, whitelists, it can still be abused.
> Something that might be worth looking into ( if the use case is there )
> would be to use Systems Manager to connect into instances directly.

> If using RDS cross regional replication of snapshots for DR