# Prerequisites

You need to have appwrite installed on your server and already created a new project in appwirte. 

You need to create an APIKEY in appwrite for this project.

The projects needs to be empty. NO DATABASES should exist. 

This script will install all databases, collections, attributes, and documents.

You need to have dart installed on you local machine.

# .env

Create a file called `.env` and configure the following parameters:

```
OKAKI_ENDPOINT=ENTER YOUR API ENDPOINT HERE (e.g. https://appwrite.okaki.org/v1)
OKAKI_DBNAME=ENTER THE DATABASE NAME HERE (e.g. testing)
OKAKI_PROJECT_ID=ENTER YOUR PROJECT ID HERE
OKAKI_APIKEY=ENTER YOUR API KEY FOR THE PROJECT HERE
```

you can ranem .env.example and get started from there.

# Run the script

You can simply run:

```bash
dart run
```

This will take a few seconds. If no errors were reported, you can check your appwrite dashboard.

