# updateCurrentSensorValue

This cloud function is triggered on this event:
```
"databases.testing.collections.measurements.documents.*.create"
```

The value of the new measurement is then stored in the "currentValue" field of the corresponding `sensor` Document in the `sensors` Collection.


## Preparations

Make sure that your appwrite installation has enough memory for functions. Check the .env file. Mine:

```
...
_APP_FUNCTIONS_SIZE_LIMIT=30000000
_APP_FUNCTIONS_TIMEOUT=1500
_APP_FUNCTIONS_BUILD_TIMEOUT=1500
_APP_FUNCTIONS_CONTAINERS=10
_APP_FUNCTIONS_CPUS=0
_APP_FUNCTIONS_MEMORY=2048
_APP_FUNCTIONS_MEMORY_SWAP=2048
_APP_FUNCTIONS_RUNTIMES=node-16.0,php-8.0,python-3.9,ruby-3.0,dart-2.17
_APP_EXECUTOR_SECRET=your-secret-key
_APP_EXECUTOR_HOST=http://appwrite-executor/v1
_APP_EXECUTOR_RUNTIME_NETWORK=appwrite_runtimes
_APP_FUNCTIONS_ENVS=node-16.0,php-7.4,python-3.9,ruby-3.0,dart-2.17
```

## Environment Variables

List of environment variables used by this cloud function:

- **APPWRITE_FUNCTION_ENDPOINT** - Endpoint of Appwrite project
- **APPWRITE_FUNCTION_API_KEY** - Appwrite API Key
- **APPWRITE_FUNCTION_PROJECT_ID** - Appwrite Project ID

## Deployment

There are two ways of deploying the Appwrite function, both having the same results, but each using a different process. We highly recommend using CLI deployment to achieve the best experience.

### Using CLI

Make sure you have [Appwrite CLI](https://appwrite.io/docs/command-line#installation) installed, and you have successfully logged into your Appwrite server. To make sure Appwrite CLI is ready, you can use the command `appwrite client --debug` and it should respond with green text `✓ Success`.

Make sure you are in the same folder as your `appwrite.json` file and run `appwrite deploy function` to deploy your function. You will be prompted to select which functions you want to deploy.

### Manual using tar.gz

Manual deployment has no requirements and uses Appwrite Console to deploy the tag. First, enter the folder of your function. Then, create a tarball of the whole folder and gzip it. After creating `.tar.gz` file, visit Appwrite Console, click on the `Deploy Tag` button and switch to the `Manual` tab. There, set the `entrypoint` to `lib/main.dart`, and upload the file we just generated.
