FROM amazonlinux 

RUN yum install -y jq 

RUN curl -o kubectl "https://s3.us-west-2.amazonaws.com/amazon-eks/1.23.17/2023-05-11/bin/linux/amd64/kubectl"
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin

ENTRYPOINT /bin/bash


