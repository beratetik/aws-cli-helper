# AWS CLI Helper
- Contains bash commands in order to ease AWS CLI ([S3](https://aws.amazon.com/s3) and [CloudFront](https://aws.amazon.com/cloudfront))

## Table of Contens
 - [Creating Bucket](#creating-bucket)
 - [Uploading File](#uploading-file)
 - [Bucket List](#bucket-list)

***

#### Creating Bucket 
``` $ createS3Bucket mydummybucket```

<hr/>

#### Uploading File
- Uploading File to the given Bucket (First Parameter: bucket, Second Parameter: file)\
``` $ uploadToBucket mydummybucket mytext.txt ```

<hr/>

#### Bucket List
- Returns Bucket List \
  ``` $ getBucketList    // returns all bucket list that you own as json format``` \

- _Output:_ 
  ```
  $ No arguments supplied
    Listing all Buckets...
    2018-07-20 11:30:20 myBucket1
    2019-03-15 15:18:08 myBucket2
    2020-04-11 15:18:08 mydummybucket
  ```
- Returns Contents of the Given Bucket
      
  ``` $ getBucketList mydummybucket   // returns the files of the given bucket as json format```
  
- _Output:_ 
  ```
    Getting 'mydummybucket' bucket...
    2020-04-11 03:33:13          0 hello/test.js
    2020-04-11 03:33:13       1045 index.html
    2020-04-11 15:17:13       0    mytext.txt
  ```
  

- _You can also export to the file as the below_ \
  ``` $ getBucketList mydummybucket  > bucketList.json```
  

- _Output: (bucketList.json)_
  ```json
    {
      "Buckets": [
          {
            "Name": "myBucket1",
            "CreationDate": "2018-07-20T11:30:20+00:00"
          },
          {
            "Name": "myBucket2",
            "CreationDate": "2019-03-15T15:18:08+00:00"
          },
          {
            "Name": "mydummybucket",
            "CreationDate": "2020-04-11T15:05:15+00:00"
          },
          ...
        ],
        "Owner": {
            "ID": "OWNER_ID"
        }
    }
    ```

