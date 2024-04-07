// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      name: json['name'] as String,
      year: json['year'] as int,
      pantoneValue: json['pantone_value'] as String,
      id: json['id'] as int?,
      color: json['color'] as String? ?? '',
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'year': instance.year,
      'pantone_value': instance.pantoneValue,
      'color': instance.color,
    };
