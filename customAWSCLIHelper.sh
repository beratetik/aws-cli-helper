# font type&colors
bold="\e[1m"
inv="\e[7"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
reset="\e[0m"

# Creates new S3 Bucket with the given bucket name
function createS3Bucket {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket name
    else
        echo ${yellow}${bold}Creating "'$1'" S3 Bucket...${reset}
        aws s3 mb s3://$1
        # aws s3api create-bucket --bucket $1 --region us-east-1 Same behavior 
        echo "${yellow}${bold}<$1> S3 Bucket successfully created${reset}"
    fi
}

# Returns Bucket List || Bucket Content (with given bucket name parameter)
function getBucketList {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket name
        aws s3 ls
    else
        echo ${yellow}${bold}Getting "'$1'" bucket...${reset}
        aws s3 ls $1 --recursive
    fi
}

# Returns Bucket List
function getBucketListS3api {
    aws s3api list-buckets
    # aws s3api list-buckets --query "Buckets[]"
}

# Uploads the given file to the given bucket
function uploadToBucket {
    if [ -z "$1" ] || [ -z "$2" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket name
    else
        echo ${yellow}${bold}All files are uploading to "'$1'" bucket..${reset}
        aws s3 cp $2 s3://$1 --acl public-read
    fi
}

# Syncing Folder Contents(default acl => public-read)
function syncBucket {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket name
    else
        echo ${yellow}${bold}Syncing folder to "'$1'" bucket..${reset}
        aws s3 sync . s3://$1 --acl public-read
        # aws s3 sync . s3://my-bucket/path --exclude "*.txt" --include "MyFile*.txt"
    fi
}

# Downloading Bucket contents to "$1Bucket" named folder
function downloadBucketContent {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket name
    else
        echo ${yellow}${bold}Downloading content from "'$1'" bucket..${reset}
        aws s3 cp s3://$1 ./$1Bucket --recursive
    fi
}

# Shows File Content of the given bucket&file
function getBucketFileContent {
    if [ -z "$1" ] || [ -z "$2" ] 
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket name
    else
        echo ${yellow}${bold}'Getting file content from "'$1'" bucket...'${reset}
        aws s3 cp s3://$1/$2 -
    fi
}

# Returns the given bucket size
function getBucketSize {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket name
    else
        echo ${yellow}${bold}Calculating '{$1}' bucket size...${reset}
        aws s3 ls s3://$1/ --recursive | awk 'BEGIN {total=0}{total+=$3}END{print total/1024/1024" MB"}'
    fi
}

# Returns info of the given bucket contents 
function getBucketInfo {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid bucket  name
    else
        echo ${yellow}${bold}Preparing '{$1}' bucket size...${reset}
        aws s3api list-objects-v2 --bucket $1
    fi
}

# Returns the list of AWS CloudFront Distribution
function cloudFrontDistributionList {
    echo ${yellow}${bold}Preparing distribution list...${reset}
    aws cloudfront list-distributions
}

# Invalidates whole folder via AWS CloudFront Distribution-ID
function invalidateCloudFront {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid distribution-id
    else
        echo ${yellow}${bold}Creating new invalidation...${reset}
        aws cloudfront create-invalidation --distribution-id $1 --paths "/*"
    fi
}

# Returns all invalidation list of the given AWS CloudFront distribution-id
function listInvalidate {
    if [ -z "$1" ]
    then
        echo ${red}${bold}No arguments supplied! 
        echo ${yellow}${bold}Please enter a valid distribution-id
    else
        echo ${yellow}${bold}Creating new invalidation...${reset}
        aws cloudfront list-invalidations --distribution-id $1
        # aws cloudfront list-invalidations --distribution-id E1G3DAUDDSO3PX --output table
    fi
}
