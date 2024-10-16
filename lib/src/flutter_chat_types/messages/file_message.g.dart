// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'file_message.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// FileMessage _$FileMessageFromJson(Map<String, dynamic> json) => FileMessage(
//       senderType: json['senderType'] as int?,
//       id: json['id'] as String?,
//       isLoading: json['isLoading'] as bool?,
//       metadata: json['metadata'] as Map<String, dynamic>?,
//       mimeType: json['mimeType'] as String?,
//       name: json['name'] as String?,
//       created_time: json['created_time'] as String?,
//       repliedMessage: json['repliedMessage'] == null
//           ? null
//           : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
//       content: json['content'] == null
//           ? null
//           : Content.fromJson(json['content'] as Map<String, dynamic>),
//       showStatus: json['showStatus'] as bool?,
//       size: json['size'] as num?,
//       status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
//       type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
//       source: json['source'],
//       uri: json['uri'] as String?,
//       isAuthor: json['isAuthor'] as bool?,
//     );

// Map<String, dynamic> _$FileMessageToJson(FileMessage instance) =>
//     <String, dynamic>{
//       'senderType': instance.senderType,
//       'id': instance.id,
//       'metadata': instance.metadata,
//       'created_time': instance.created_time,
//       'repliedMessage': instance.repliedMessage,
//       'content': instance.content,
//       'showStatus': instance.showStatus,
//       'isAuthor': instance.isAuthor,
//       'status': _$StatusEnumMap[instance.status],
//       'type': _$MessageTypeEnumMap[instance.type]!,
//       'source': instance.source,
//       'isLoading': instance.isLoading,
//       'mimeType': instance.mimeType,
//       'name': instance.name,
//       'size': instance.size,
//       'uri': instance.uri,
//     };

// const _$StatusEnumMap = {
//   Status.delivered: 'delivered',
//   Status.error: 'error',
//   Status.seen: 'seen',
//   Status.sending: 'sending',
//   Status.sent: 'sent',
// };

// const _$MessageTypeEnumMap = {
//   MessageType.audio: 'audio',
//   MessageType.custom: 'custom',
//   MessageType.file: 'file',
//   MessageType.image: 'image',
//   MessageType.system: 'system',
//   MessageType.text: 'text',
//   MessageType.unsupported: 'unsupported',
//   MessageType.video: 'video',
//   MessageType.carousel: 'carousel',
//   MessageType.payload: 'payload',
//   MessageType.typing: 'typing',
//   MessageType.quick_reply: 'quick_reply',
// };
