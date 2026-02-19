// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubmissionModelAdapter extends TypeAdapter<SubmissionModel> {
  @override
  final int typeId = 0;

  @override
  SubmissionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubmissionModel(
      questionnaireId: fields[0] as String,
      questionnaireTitle: fields[1] as String,
      answers: (fields[2] as Map).cast<String, String>(),
      submittedAt: fields[3] as String,
      latitude: fields[4] as double,
      longitude: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SubmissionModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.questionnaireId)
      ..writeByte(1)
      ..write(obj.questionnaireTitle)
      ..writeByte(2)
      ..write(obj.answers)
      ..writeByte(3)
      ..write(obj.submittedAt)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmissionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
