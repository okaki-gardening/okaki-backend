import 'package:dart_appwrite/dart_appwrite.dart';

import 'package:dotenv/dotenv.dart';

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  final String? dbName = env['DBNAME'];
  final String? apikey = env['APIKEY'];
  final String? projectID = env['PROJECT_ID'];
  final String? endpoint = env['ENDPOINT'];

  if ((dbName == null) ||
      (apikey == null) ||
      (projectID == null) ||
      (endpoint == null)) {
    print("ERROR: please check your .env file");
    return;
  }

  // Init SDK
  Client client = Client();
  Databases databases = Databases(client);

  client
      .setEndpoint(endpoint) // Your API Endpoint
      .setProject(projectID) // Your project ID
      .setKey(apikey); // Your secret API key

  await databases.create(
    databaseId: dbName,
    name: dbName,
  );

  await databases.createCollection(
      databaseId: dbName,
      collectionId: 'gardens',
      name: 'gardens',
      permissions: [Permission.read(Role.any())]);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'gardens',
      key: 'ownerID',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'gardens',
      key: 'name',
      size: 128,
      xrequired: true);

  print("Collection gardens created");

  await databases.createCollection(
      databaseId: dbName,
      collectionId: 'sensorTypes',
      name: 'sensorTypes',
      permissions: [
        Permission.read(Role.any()),
        Permission.create(Role.any())
      ]);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensorTypes',
      key: 'name',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensorTypes',
      key: 'unitName',
      size: 128,
      xrequired: false);

  print("Collection sensorTypes created");

  await databases.createCollection(
      databaseId: dbName,
      collectionId: 'sensors',
      name: 'sensors',
      permissions: [
        Permission.read(Role.any()),
        Permission.create(Role.any())
      ]);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensors',
      key: 'name',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensors',
      key: 'ownerID',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensors',
      key: 'gardenID',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensors',
      key: 'sensorTypeID',
      size: 128,
      xrequired: false);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensors',
      key: 'comments',
      size: 320,
      xrequired: false);
  print("Collection sensors created");

  await databases.createCollection(
      databaseId: dbName,
      collectionId: 'measurements',
      name: 'measurements',
      permissions: [
        Permission.read(Role.any()),
        Permission.create(Role.any())
      ]);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'measurements',
      key: 'sensorID',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'measurements',
      key: 'sensorTypeID',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'measurements',
      key: 'value_string',
      size: 128,
      xrequired: false);
  await databases.createIntegerAttribute(
      databaseId: dbName,
      collectionId: 'measurements',
      key: 'value_int',
      xrequired: false);
  await databases.createFloatAttribute(
      databaseId: dbName,
      collectionId: 'measurements',
      key: 'value_float',
      xrequired: false);
  await databases.createBooleanAttribute(
      databaseId: dbName,
      collectionId: 'measurements',
      key: 'value_bool',
      xrequired: false);
  print("Collection measurements created");

  /////////////////////////////////////////////////////
  /// CREATE DOCUMENTS
  /////////////////////////////////////////////////////

  //wait until all service runners finished their tasks
  await Future.delayed(Duration(seconds: 10));

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'generic_bool'},
  );
}
