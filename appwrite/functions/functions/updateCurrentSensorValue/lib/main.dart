import 'dart:async';
import 'dart:convert';

import 'package:appwrite_function/measurement_model.dart';
import 'package:appwrite_function/sensor_model.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';

Future<void> start(final req, final res) async {
  String payload = "";
  bool execute = true;

  if (req.variables['APPWRITE_FUNCTION_ENDPOINT'] == null ||
      req.variables['APPWRITE_FUNCTION_PROJECT_ID'] == null ||
      req.variables['APPWRITE_FUNCTION_API_KEY'] == null) {
    print('Please provide all required environment variables.');
    payload = 'Please provide all required environment variables.';
    execute = false;
  }

  if (execute) {
    if (req.variables['APPWRITE_FUNCTION_TRIGGER'] == null ||
        req.variables['APPWRITE_FUNCTION_EVENT'] == null ||
        req.variables['APPWRITE_FUNCTION_EVENT_DATA'] == null) {
      print('Function was not called by an event.');
      payload = 'Function was not called by an event.';
      execute = false;
    }
  }

  if (execute) {
    String function_trigger =
        req.variables['APPWRITE_FUNCTION_TRIGGER'].toString();
    if (function_trigger != "event") {
      print('Function was not called by an event.');
      payload = 'Function was not called by an event.';
      execute = false;
    }
  }

  if (execute) {
    String function_event = req.variables['APPWRITE_FUNCTION_EVENT'].toString();
    if (!function_event
        .startsWith("databases.testing.collections.measurements.documents")) {
      print('Function was not called by the correct event.');
      payload = 'Function was not called by the correct event. Instead: ';
      payload += function_event;
      execute = false;
    }
  }

  if (execute) {
    String function_event_data_string =
        req.variables['APPWRITE_FUNCTION_EVENT_DATA'].toString();
    var document = jsonDecode(function_event_data_string);

    Document d = Document.fromMap(document);
    Measurement measurement = Measurement.fromMap(d.data);
    String sensorID = measurement.sensorID;

    print("sensorID: $sensorID");

    try {
      final client = Client()
          .setEndpoint(req.variables['APPWRITE_FUNCTION_ENDPOINT'])
          .setProject(req.variables['APPWRITE_FUNCTION_PROJECT_ID'])
          .setKey(req.variables['APPWRITE_FUNCTION_API_KEY']);

      Databases databases = Databases(client);

      DocumentList documents = await databases.listDocuments(
          databaseId: d.$databaseId,
          collectionId: 'sensors',
          queries: [Query.equal('\$id', sensorID)]);

      if (documents.total == 0) {
        print("no sensor found!");
        res.json({
          'message': 'updateCurrentSensorValue ERROR',
          'debug': 'no sensor found!',
        });
      } else {
        Document sensorDocument = documents.documents.first;
        SensorModel sensor = SensorModel.fromMap(sensorDocument.data);

        String newValue = "null";
        if (measurement.value_float != null) {
          newValue = measurement.value_float.toString();
        } else if (measurement.value_int != null) {
          newValue = measurement.value_int.toString();
        } else if (measurement.value_bool != null) {
          newValue = measurement.value_bool.toString();
        } else if (measurement.value_string != null) {
          newValue = measurement.value_string!;
        }

        var newData = {'currentValue': '$newValue'};

        Document newDocument = await databases.updateDocument(
            databaseId: sensorDocument.$databaseId,
            collectionId: sensorDocument.$collectionId,
            documentId: sensorDocument.$id,
            data: newData);

        res.json({
          'message': 'updateCurrentSensorValue OK',
          'debug': payload,
          'measurement': measurement,
          'oldSensor': sensor,
          'newSensor': newDocument.data
        });
      }
    } catch (e) {
      print("Error while creating Client: $e ");
      res.json({
        'message': 'updateCurrentSensorValue ERROR',
        'debug': 'Error while creating Client: $e ',
      });
    }
  } else {
    res.json({
      'message': 'updateCurrentSensorValue ERROR',
      'debug': payload,
    });
  }
}
