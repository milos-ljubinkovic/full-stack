STACK_NAME=$1
DOMAIN=$2

echo $STACK_NAME
echo $DOMAIN
ACCOUNT=`aws sts get-caller-identity --query "Account" --output text` # get the AWS account it
HOSTED_ZONE=`aws route53 list-hosted-zones-by-name --dns-name $DOMAIN --query "HostedZones[0].Id" --output text` # get the hosted zone id for the domain
BUCKET=deploy-bucket-$ACCOUNT 
aws s3api create-bucket --bucket $BUCKET  --region $AWS_REGION # create a bucket for temporary storage of deploment artifacts
aws cloudformation package --template-file ./cf.yml --s3-bucket $BUCKET --output-template-file packaged-sam.yaml # package everything up
aws cloudformation deploy --template-file packaged-sam.yaml  --stack-name $STACK_NAME --capabilities CAPABILITY_NAMED_IAM CAPABILITY_IAM CAPABILITY_AUTO_EXPAND --parameter-override DOMAIN=$DOMAIN HOSTEDZONE=$HOSTED_ZONE --s3-bucket $BUCKET  # deploy
aws s3 sync ./web s3://web-$STACK_NAME-$ACCOUNT/