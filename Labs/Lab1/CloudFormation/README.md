## Steps to Run the Source

1. **Clone the Repository**
```sh
git clone https://github.com/ThaiThanh0703/NT548_DevOps.git
cd  NT548_Devops/Labs/Lab1/Cloudformation
```

2. **Apply Cloudformation code**
    1. Create Key Pair for EC2 instances :
         ```
         aws ec2 create-key-pair --key-name group23 --query 'KeyMaterial' --output text > group23.pem
         ```
      2. Create S3 Bucket to store CloudFormation template file:
         ```
         aws s3api create-bucket --bucket group23-s3 --region us-east-1 
         ```
      3. Upload all file template to S3 Bucket:
         ```
         aws s3 sync . s3://group23-s3
         ```
      4. Create CloudFormation stack with these parameters:
         ```
         aws cloudformation create-stack --stack-name group23-stack --template-body file://main.yaml
         ```
      5. Check status of CloudFormation stack:
         ```
         aws cloudformation describe-stacks --stack-name group23-stack
         ```
      6. Clean up:
         ```
         aws cloudformation delete-stack --stack-name group23-stack
         ```