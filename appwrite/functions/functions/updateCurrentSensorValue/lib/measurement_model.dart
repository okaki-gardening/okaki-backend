// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Measurement {
  final String sensorID;
  final String? value_string;
  final int? value_int;
  final double? value_float;
  final bool? value_bool;
  final String sensorTypeID;
  Measurement({
    required this.sensorID,
    this.value_string,
    this.value_int,
    this.value_float,
    this.value_bool,
    required this.sensorTypeID,
  });

  Measurement copyWith({
    String? sensorID,
    String? value_string,
    int? value_int,
    double? value_float,
    bool? value_bool,
    String? sensorTypeID,
  }) {
    return Measurement(
      sensorID: sensorID ?? this.sensorID,
      value_string: value_string ?? this.value_string,
      value_int: value_int ?? this.value_int,
      value_float: value_float ?? this.value_float,
      value_bool: value_bool ?? this.value_bool,
      sensorTypeID: sensorTypeID ?? this.sensorTypeID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sensorID': sensorID,
      'value_string': value_string,
      'value_int': value_int,
      'value_float': value_float,
      'value_bool': value_bool,
      'sensorTypeID': sensorTypeID,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      sensorID: map['sensorID'] as String,
      value_string:
          map['value_string'] != null ? map['value_string'] as String : null,
      value_int: map['value_int'] != null ? map['value_int'] as int : null,
      value_float:
          map['value_float'] != null ? map['value_float'] as double : null,
      value_bool: map['value_bool'] != null ? map['value_bool'] as bool : null,
      sensorTypeID: map['sensorTypeID'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Measurement.fromJson(String source) =>
      Measurement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Measurement(sensorID: $sensorID, value_string: $value_string, value_int: $value_int, value_float: $value_float, value_bool: $value_bool, sensorTypeID: $sensorTypeID)';
  }

  @override
  bool operator ==(covariant Measurement other) {
    if (identical(this, other)) return true;

    return other.sensorID == sensorID &&
        other.value_string == value_string &&
        other.value_int == value_int &&
        other.value_float == value_float &&
        other.value_bool == value_bool &&
        other.sensorTypeID == sensorTypeID;
  }

  @override
  int get hashCode {
    return sensorID.hashCode ^
        value_string.hashCode ^
        value_int.hashCode ^
        value_float.hashCode ^
        value_bool.hashCode ^
        sensorTypeID.hashCode;
  }
}
