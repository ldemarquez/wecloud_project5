# wecloud_project5
******  Project 5 ******

Member of the team: 
Luis De Marquez
Prithvi kohli
Sara Siddiqui
Bhargav Dalwadi

This repo has 3 sub directories under the top workdir

Directory  docker (  Dockerfile and dependencied to build local docker images)

Directory infra  ( scripts to create AWS EKS infrastructure)

Directory manifest ( EKS kubernetes manifest)

##### Create docker images

cd dir docker


1. Build local your docker image

1.1 Create your Dockerfile and put all dependencies under the dir docker

ldemarquez@Luiss-MacBook-Pro-2 docker % ls -la 
total 16
drwxr-xr-x   6 ldemarquez  staff  192 25 Jul 11:38 .
drwxr-xr-x   7 ldemarquez  staff  224 25 Jul 13:47 ..
-rw-r--r--@  1 ldemarquez  staff  183  4 Mar  2022 Dockerfile
-rw-r--r--@  1 ldemarquez  staff  744 29 Sep  2020 package.json
drwxr-xr-x@  9 ldemarquez  staff  288 29 Sep  2020 public
drwxr-xr-x@ 10 ldemarquez  staff  320 24 Jul 11:46 src

ldemarquez@Luiss-MacBook-Pro-2 docker % cat Dockerfile
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html%

1.2 Build locally your docker image

docker-react % docker build -t wecloud_project5:0.0.2 . 



[+] Building 15.7s (14/14) FINISHED                                                                                                
 => [internal] load build definition from Dockerfile                                                                          0.0s
 => => transferring dockerfile: 120B                                                                                          0.0s
 => [internal] load .dockerignore                                                                                             0.0s
 => => transferring context: 2B                                                                                               0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                                               0.2s
 => [internal] load metadata for docker.io/library/node:16-alpine                                                             0.2s
 => [internal] load build context                                                                                             0.0s
 => => transferring context: 155.45kB                                                                                         0.0s
 => [builder 1/6] FROM docker.io/library/node:16-alpine@sha256:6c381d5dc2a11dcdb693f0301e8587e43f440c90cdb8933eaaaabb905d44c  0.0s
 => CACHED [stage-1 1/2] FROM docker.io/library/nginx@sha256:08bc36ad52474e528cc1ea3426b5e3f4bad8a130318e3140d6cfe29c8892c7e  0.0s
 => CACHED [builder 2/6] WORKDIR /app                                                                                         0.0s
 => CACHED [builder 3/6] COPY package.json .                                                                                  0.0s
 => CACHED [builder 4/6] RUN npm install                                                                                      0.0s
 => [builder 5/6] COPY . .                                                                                                    0.0s
 => [builder 6/6] RUN npm run build                                                                                          13.0s
 => [stage-1 2/2] COPY --from=builder /app/build /usr/share/nginx/html                                                        0.0s 
 => exporting to image                                                                                                        0.0s 
 => => exporting layers                                                                                                       0.0s 
 => => writing image sha256:4cee0dc693ec23d296af4ede8814006eb5454d3504342620bf03a19cddd3c064                                  0.0s 
 => => naming to docker.io/library/wecloud_project5:0.0.2                                                                     0.0s 
docker-react % 

1.3   Check local image, tag and push 

docker-react % docker image ls wecloud_project5
REPOSITORY         TAG       IMAGE ID       CREATED         SIZE
wecloud_project5   0.0.2     4cee0dc693ec   3 minutes ago   187MB

docker image tag wecloud_project5:0.0.2 ldemarquez/wecloud_project5:0.0.2 


 docker push ldemarquez/wecloud_project5:0.0.2

The push refers to repository [docker.io/ldemarquez/wecloud_project5]
7f64e637d25b: Pushed 
3c9d04c9ebd5: Mounted from ldemarquez/p5-react 
434c6a715c30: Mounted from ldemarquez/p5-react 
9fdfd12bc85b: Mounted from ldemarquez/p5-react 
f36897eea34d: Mounted from ldemarquez/p5-react 
1998c5cd2230: Mounted from ldemarquez/p5-react 
b821d93f6666: Mounted from ldemarquez/p5-react 
24839d45ca45: Mounted from ldemarquez/p5-react 
0.0.2: digest: sha256:8de472443778571c78c6fe61794522af764750efff775a5169e4c0ec4649d856 size: 1988



##### Create Infrastructure

1. Pre-requisites: 

eksctl and aws cli have to be installed.  

Verify credential with script chk_aws.sh 

eksctl 

 % eksctl info

eksctl version: 0.124.0
kubectl version: v1.23.0
OS: darwin

2. Create EKS Cluster 

cd dir infra

Edit Variables in script create-ekscluster.sh for your environment

#Variables
CLUSTER_NAME=eksp5
REGION=us-east-1
ZONE1=us-east-1a
ZONE2=us-east-1b

Run script ./create-ekscluster.sh 

% ./create-ekscluster.sh 

2023-07-25 13:40:14 [ℹ]  eksctl version 0.124.0
2023-07-25 13:40:14 [ℹ]  using region us-east-1
2023-07-25 13:40:14 [ℹ]  subnets for us-east-1a - public:192.168.0.0/19 private:192.168.64.0/19
2023-07-25 13:40:14 [ℹ]  subnets for us-east-1b - public:192.168.32.0/19 private:192.168.96.0/19
2023-07-25 13:40:14 [ℹ]  using Kubernetes version 1.23
2023-07-25 13:40:14 [ℹ]  creating EKS cluster "eksp5" in "us-east-1" region with 
2023-07-25 13:40:14 [ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=us-east-1 --cluster=eksp5'
2023-07-25 13:40:14 [ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "eksp5" in "us-east-1"
2023-07-25 13:40:14 [ℹ]  CloudWatch logging will not be enabled for cluster "eksp5" in "us-east-1"
2023-07-25 13:40:14 [ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=us-east-1 --cluster=eksp5'
2023-07-25 13:40:14 [ℹ]  
2 sequential tasks: { create cluster control plane "eksp5", wait for control plane to become ready 
}
2023-07-25 13:40:14 [ℹ]  building cluster stack "eksctl-eksp5-cluster"
2023-07-25 13:40:15 [ℹ]  deploying stack "eksctl-eksp5-cluster"
2023-07-25 13:40:45 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:41:15 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:42:15 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:43:15 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:44:15 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:45:16 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:46:16 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:47:16 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:48:17 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:49:17 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:50:17 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-cluster"
2023-07-25 13:52:20 [ℹ]  waiting for the control plane to become ready
2023-07-25 13:52:20 [✔]  saved kubeconfig as "/Users/ldemarquez/.kube/config"
2023-07-25 13:52:20 [ℹ]  no tasks
2023-07-25 13:52:20 [✔]  all EKS cluster resources for "eksp5" have been created
2023-07-25 13:52:21 [ℹ]  kubectl command should work with "/Users/ldemarquez/.kube/config", try 'kubectl get nodes'
2023-07-25 13:52:21 [✔]  EKS cluster "eksp5" in "us-east-1" region is ready

Verify 

% eksctl get cluster 

NAME		REGION		EKSCTL CREATED
eksdemo1	us-east-1	True
eksp5		us-east-1	True

kubectl config view |grep eksp5

  name: eksp5.us-east-1.eksctl.io
    cluster: eksp5.us-east-1.eksctl.io
    user: root@eksp5.us-east-1.eksctl.io
  name: root@eksp5.us-east-1.eksctl.io
current-context: root@eksp5.us-east-1.eksctl.io
- name: root@eksp5.us-east-1.eksctl.io
      - eksp5


% kubectl get namespaces 

NAME              STATUS   AGE
default           Active   22m
kube-node-lease   Active   22m
kube-public       Active   22m
kube-system       Active   22m

## Create namespace p5


% kubectl create namespace p5 

namespace/p5 created


% kubectl get namespaces      

NAME              STATUS   AGE
default           Active   22m
kube-node-lease   Active   22m
kube-public       Active   22m
kube-system       Active   22m
p5                Active   5s


4. Create IAM OIDC Provider

cd infra

Edit Variables in script create-iamoidc-provider.sh for your environment

#Variables
CLUSTER_NAME=eksp5
REGION=us-east-1


% ./create-iamoidc-provider.sh

2023-07-25 14:18:23 [ℹ]  will create IAM Open ID Connect provider for cluster "eksp5" in "us-east-1"
2023-07-25 14:18:23 [✔]  created IAM Open ID Connect provider for cluster "eksp5" in "us-east-1"


3. Create nodegroup 

Pre-requisites a valid EC2 KeyPair in your working dir

example project2KeyPair.pem

cd infra

Edit Variables in script create-nodegroup.sh for your environment

#Variables
CLUSTER_NAME=eksp5
REGION=us-east-1
NODEGROUP_NAME=eksp5-ng-private1
NODE_TYPE=t3.medium
NODE_MIN=2
NODE_MAX=4
NODE_VOL_SIZE=20
SSH_PUBLIC_KEY=project2KeyPair


!!!!!!! NOTE:  Remenber never commit your EC2 KeyPair to your repo !!!!!!!!


 % ./create-nodegroup.sh

2023-07-25 14:37:59 [ℹ]  will use version 1.23 for new nodegroup(s) based on control plane version
2023-07-25 14:38:01 [ℹ]  nodegroup "eksp5-ng-private1" will use "" [AmazonLinux2/1.23]
2023-07-25 14:38:01 [ℹ]  using EC2 key pair %!q(*string=<nil>)
2023-07-25 14:38:01 [ℹ]  1 nodegroup (eksp5-ng-private1) was included (based on the include/exclude rules)
2023-07-25 14:38:01 [ℹ]  will create a CloudFormation stack for each of 1 managed nodegroups in cluster "eksp5"
2023-07-25 14:38:02 [ℹ]  
2 sequential tasks: { fix cluster compatibility, 1 task: { 1 task: { create managed nodegroup "eksp5-ng-private1" } } 
}
2023-07-25 14:38:02 [ℹ]  checking cluster stack for missing resources
2023-07-25 14:38:02 [ℹ]  cluster stack has all required resources
2023-07-25 14:38:02 [ℹ]  building managed nodegroup stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 14:38:03 [ℹ]  deploying stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 14:38:03 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 14:38:33 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 14:39:31 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 14:40:09 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 14:41:34 [ℹ]  waiting for CloudFormation stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 14:41:34 [ℹ]  no tasks
2023-07-25 14:41:34 [✔]  created 0 nodegroup(s) in cluster "eksp5"
2023-07-25 14:41:34 [ℹ]  nodegroup "eksp5-ng-private1" has 2 node(s)
2023-07-25 14:41:34 [ℹ]  node "ip-192-168-102-59.ec2.internal" is ready
2023-07-25 14:41:34 [ℹ]  node "ip-192-168-82-136.ec2.internal" is ready
2023-07-25 14:41:34 [ℹ]  waiting for at least 2 node(s) to become ready in "eksp5-ng-private1"
2023-07-25 14:41:35 [ℹ]  nodegroup "eksp5-ng-private1" has 2 node(s)
2023-07-25 14:41:35 [ℹ]  node "ip-192-168-102-59.ec2.internal" is ready
2023-07-25 14:41:35 [ℹ]  node "ip-192-168-82-136.ec2.internal" is ready
2023-07-25 14:41:35 [✔]  created 1 managed nodegroup(s) in cluster "eksp5"
2023-07-25 14:41:35 [ℹ]  checking security group configuration for all nodegroups
2023-07-25 14:41:35 [ℹ]  all nodegroups have up-to-date cloudformation templates

% eksctl get nodegroup --cluster eksp5

CLUSTER	NODEGROUP		STATUS	CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID	ASG NAME			TYPE
eksp5	eksp5-ng-private1	ACTIVE	2023-07-25T18:38:23Z	2		4		2			t3.medium	AL2_x86_64	eks-eksp5-ng-private1-e4c4c72c-2d36-2c8c-e858-7cf28eb8c3a5	managed

Please notice below that the EKS nodes don't have EXTERNAL-IP, all coonectivity to the nodes, pods and services will be via the Networl Load Balancers

% kubectl get nodes -o wide

NAME                             STATUS   ROLES    AGE     VERSION                INTERNAL-IP      EXTERNAL-IP   OS-IMAGE         KERNEL-VERSION                 CONTAINER-RUNTIME
ip-192-168-102-59.ec2.internal   Ready    <none>   2m30s   v1.23.17-eks-a5565ad   192.168.102.59   <none>        Amazon Linux 2   5.4.247-162.350.amzn2.x86_64   docker://20.10.23
ip-192-168-82-136.ec2.internal   Ready    <none>   2m28s   v1.23.17-eks-a5565ad   192.168.82.136   <none>        Amazon Linux 2   5.4.247-162.350.amzn2.x86_64   docker://20.10.23



##### Deploy Kubernetes manifest Web App deployment, Web Load Balancer and Web Service

Deploy all manifest in namespace p5

Verify name space p5 was created 

% kubectl get namespace p5 
NAME   STATUS   AGE
p5     Active   69m

% kubectl get all -n p5    

No resources found in p5 namespace.

on the top of the working dir

ldemarquez@Luiss-MacBook-Pro-2 react-project5 % kubectl apply -f manifest/ -n p5 

deployment.apps/web created
service/nlb-web created
service/web created

verify resources ( pod / services deployment and replicaset )

ldemarquez@Luiss-MacBook-Pro-2 react-project5 % kubectl get all -n p5            
NAME                      READY   STATUS    RESTARTS   AGE
pod/web-945fcc47d-txdsd   1/1     Running   0          26s
pod/web-945fcc47d-zhfhb   1/1     Running   0          26s

NAME              TYPE           CLUSTER-IP       EXTERNAL-IP                                                                     PORT(S)        AGE
service/nlb-web   LoadBalancer   10.100.124.15    ac6e42a47ab8547bf98be6b5ec74d06b-97a10385a376f0ea.elb.us-east-1.amazonaws.com   80:31314/TCP   27s
service/web       ClusterIP      10.100.124.125   <none>                                                                          80/TCP         26s

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/web   2/2     2            2           27s

NAME                            DESIRED   CURRENT   READY   AGE
replicaset.apps/web-945fcc47d   2         2         2       27s

wait 5 min that the service/nlb-web   LoadBalancer is fully created and has public IP DNS assign to it


No public IP and DNS entry created for the NLB network Load Balancer 

nslookup ac6e42a47ab8547bf98be6b5ec74d06b-97a10385a376f0ea.elb.us-east-1.amazonaws.com
Server:		2607:f798:18:10:0:640:7125:5204
Address:	2607:f798:18:10:0:640:7125:5204#53

** server can't find ac6e42a47ab8547bf98be6b5ec74d06b-97a10385a376f0ea.elb.us-east-1.amazonaws.com: NXDOMAIN

after 5 minutes 

nslookup ac6e42a47ab8547bf98be6b5ec74d06b-97a10385a376f0ea.elb.us-east-1.amazonaws.com

Server:		2607:f798:18:10:0:640:7125:5204
Address:	2607:f798:18:10:0:640:7125:5204#53

Non-authoritative answer:
Name:	ac6e42a47ab8547bf98be6b5ec74d06b-97a10385a376f0ea.elb.us-east-1.amazonaws.com
Address: 44.216.141.63
Name:	ac6e42a47ab8547bf98be6b5ec74d06b-97a10385a376f0ea.elb.us-east-1.amazonaws.com
Address: 34.231.123.65

Verify access to the Web App suing the NLB 

example below http://nlb

in the browser http://ac6e42a47ab8547bf98be6b5ec74d06b-97a10385a376f0ea.elb.us-east-1.amazonaws.com




##### Delete and remove resource


1.  Remove  resources deployed in namespace p5

on the top of the working dir

% kubectl delete -f manifest -n p5 

deployment.apps "web" deleted
service "nlb-web" deleted
service "web" deleted


% kubectl get all -n p5                                                              

No resources found in p5 namespace.

2. Remove node group 

cd infra


% eksctl get nodegroup --cluster=eksp5

CLUSTER	NODEGROUP		STATUS	CREATED			MIN SIZE	MAX SIZE	DESIRED CAPACITY	INSTANCE TYPE	IMAGE ID	ASG NAME			TYPE
eksp5	eksp5-ng-private1	ACTIVE	2023-07-25T18:38:23Z	2		4		2			t3.medium	AL2_x86_64	eks-eksp5-ng-private1-e4c4c72c-2d36-2c8c-e858-7cf28eb8c3a5	managed

ldemarquez@Luiss-MacBook-Pro-2 react-project5 % eksctl delete nodegroup --cluster=eksp5 --name=eksp5-ng-private1
2023-07-25 15:37:47 [ℹ]  1 nodegroup (eksp5-ng-private1) was included (based on the include/exclude rules)
2023-07-25 15:37:47 [ℹ]  will drain 1 nodegroup(s) in cluster "eksp5"
2023-07-25 15:37:47 [ℹ]  starting parallel draining, max in-flight of 1
2023-07-25 15:37:47 [ℹ]  cordon node "ip-192-168-102-59.ec2.internal"
2023-07-25 15:37:47 [ℹ]  cordon node "ip-192-168-82-136.ec2.internal"
2023-07-25 15:37:59 [✔]  drained all nodes: [ip-192-168-82-136.ec2.internal ip-192-168-102-59.ec2.internal]
2023-07-25 15:37:59 [ℹ]  will delete 1 nodegroups from cluster "eksp5"
2023-07-25 15:38:00 [ℹ]  1 task: { 1 task: { delete nodegroup "eksp5-ng-private1" [async] } }
2023-07-25 15:38:00 [ℹ]  will delete stack "eksctl-eksp5-nodegroup-eksp5-ng-private1"
2023-07-25 15:38:00 [ℹ]  will delete 0 nodegroups from auth ConfigMap in cluster "eksp5"
2023-07-25 15:38:00 [✔]  deleted 1 nodegroup(s) from cluster "eksp5"


3. Remove EKS Cluster

eksctl get clusters

NAME		REGION		EKSCTL CREATED
eksdemo1	us-east-1	True
eksp5		us-east-1	True

eksctl delete cluster eksp5 

eksctl delete cluster eksp5

2023-07-25 15:41:23 [ℹ]  deleting EKS cluster "eksp5"
2023-07-25 15:41:24 [ℹ]  deleted 0 Fargate profile(s)
2023-07-25 15:41:24 [✔]  kubeconfig has been updated
2023-07-25 15:41:24 [ℹ]  cleaning up AWS load balancers created by Kubernetes objects of Kind Service or Ingress
2023-07-25 15:41:25 [ℹ]  
2 sequential tasks: { delete IAM OIDC provider, delete cluster control plane "eksp5" [async] 
}
2023-07-25 15:41:26 [ℹ]  will delete stack "eksctl-eksp5-cluster"
2023-07-25 15:41:26 [✔]  all cluster resources were deleted

wait 5 minutes until the the cluster has been fully deleted

eksctl get clusters
NAME		REGION		EKSCTL CREATED
eksdemo1	us-east-1	True
