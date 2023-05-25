import 'package:dart_appwrite/dart_appwrite.dart';

import 'package:dotenv/dotenv.dart';

Client client = Client();
Databases databases = Databases(client);
String dbName = 'testing';

void createTestData() async {
  /////////////////////////////////////////////////////
  /// CREATE DOCUMENTS
  /////////////////////////////////////////////////////

  //wait until all service runners finished their tasks
  await Future.delayed(Duration(seconds: 10));

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'bool'},
  );

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'int'},
  );

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'float'},
  );

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'string'},
  );

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'json'},
  );

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'temperature', 'unitName': '°C'},
  );

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'humidity', 'unitName': '%'},
  );

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'sensorTypes',
    documentId: 'unique()',
    data: {'name': 'soilmoisture'},
  );

  print('created sensorTypes.');

  await databases.createDocument(
    databaseId: dbName,
    collectionId: 'gardens',
    documentId: 'garden1',
    data: {'ownerID': '644bc703994fe5db41d2', 'name': 'Garten 1'},
  );

  print('created garden1.');
}

void main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  dbName = env.getOrElse('OKAKI_DBNAME', () => 'testing');

  final String? apikey = env['OKAKI_APIKEY'];
  final String? projectID = env['OKAKI_PROJECT_ID'];
  final String? endpoint = env['OKAKI_ENDPOINT'];

  if ((apikey == null) || (projectID == null) || (endpoint == null)) {
    print("ERROR: please check your .env file");
    return;
  }

  // Init appwrite SDK
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
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'sensors',
      key: 'currentValue',
      size: 128,
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
      key: 'value',
      size: 128,
      xrequired: true);
  print("Collection measurements created");

  await databases.createCollection(
      databaseId: dbName,
      collectionId: 'devices',
      name: 'devices',
      permissions: [
        Permission.read(Role.any()),
        Permission.create(Role.any())
      ]);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'devices',
      key: 'ownerID',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'devices',
      key: 'name',
      size: 128,
      xrequired: true);
  await databases.createStringAttribute(
      databaseId: dbName,
      collectionId: 'devices',
      key: 'key',
      size: 128,
      xrequired: true);
  print("Collection devices created");

  /////////////////////////////////////////////////////
  /// CREATE INDEXES
  /////////////////////////////////////////////////////

  //wait until all service runners finished their tasks
  await Future.delayed(Duration(seconds: 10));

  await databases.createIndex(
    databaseId: dbName,
    collectionId: 'gardens',
    key: 'index_id',
    type: 'unique',
    attributes: ['\$id'],
    orders: ['ASC'],
  );

  await databases.createIndex(
    databaseId: dbName,
    collectionId: 'gardens',
    key: 'index_ownerID',
    type: 'key',
    attributes: ['ownerID'],
    orders: ['ASC'],
  );

  print("Indexes for Collection gardens created");

  await databases.createIndex(
    databaseId: dbName,
    collectionId: 'sensors',
    key: 'index_id',
    type: 'unique',
    attributes: ['\$id'],
    orders: ['ASC'],
  );

  await databases.createIndex(
    databaseId: dbName,
    collectionId: 'sensors',
    key: 'index_ownerID',
    type: 'key',
    attributes: ['ownerID'],
    orders: ['ASC'],
  );

  await databases.createIndex(
    databaseId: dbName,
    collectionId: 'sensors',
    key: 'index_gardenID',
    type: 'key',
    attributes: ['gardenID'],
    orders: ['ASC'],
  );

  await databases.createIndex(
    databaseId: dbName,
    collectionId: 'sensors',
    key: 'index_sensorTypeID',
    type: 'key',
    attributes: ['sensorTypeID'],
    orders: ['ASC'],
  );

  print("Indexes for Collection sensors created");
}
