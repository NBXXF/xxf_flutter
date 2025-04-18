// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  gender: json['gender'] as String,
  status: json['status'] as String,
  created_at: json['created_at'] as String,
  updated_at: json['updated_at'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'gender': instance.gender,
  'status': instance.status,
  'created_at': instance.created_at,
  'updated_at': instance.updated_at,
};

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
  code: (json['code'] as num).toInt(),
  meta: json['meta'],
  data: json['data'] as List<dynamic>,
);

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'meta': instance.meta,
      'data': instance.data,
    };
