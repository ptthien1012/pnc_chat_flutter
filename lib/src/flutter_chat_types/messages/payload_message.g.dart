// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayloadMessage _$PayloadMessageFromJson(Map<String, dynamic> json) =>
    PayloadMessage(
      senderType: json['senderType'] as int?,
      id: json['id'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      previewData: json['previewData'] == null
          ? null
          : PreviewData.fromJson(json['previewData'] as Map<String, dynamic>),
      created_time: json['created_time'] as String?,
      repliedMessage: json['repliedMessage'] == null
          ? null
          : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
      showStatus: json['showStatus'] as bool?,
      status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      text: json['text'] as String?,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      source: json['source'],
      isAuthor: json['isAuthor'] as bool?,
    );

Map<String, dynamic> _$PayloadMessageToJson(PayloadMessage instance) =>
    <String, dynamic>{
      'senderType': instance.senderType,
      'id': instance.id,
      'metadata': instance.metadata,
      'created_time': instance.created_time,
      'repliedMessage': instance.repliedMessage,
      'content': instance.content,
      'showStatus': instance.showStatus,
      'isAuthor': instance.isAuthor,
      'status': _$StatusEnumMap[instance.status],
      'type': _$MessageTypeEnumMap[instance.type]!,
      'source': instance.source,
      'previewData': instance.previewData,
      'text': instance.text,
    };

const _$StatusEnumMap = {
  Status.delivered: 'delivered',
  Status.error: 'error',
  Status.seen: 'seen',
  Status.sending: 'sending',
  Status.sent: 'sent',
};

const _$MessageTypeEnumMap = {
  MessageType.audio: 'audio',
  MessageType.custom: 'custom',
  MessageType.file: 'file',
  MessageType.image: 'image',
  MessageType.system: 'system',
  MessageType.text: 'text',
  MessageType.unsupported: 'unsupported',
  MessageType.video: 'video',
  MessageType.carousel: 'carousel',
  MessageType.payload: 'payload',
  MessageType.typing: 'typing',
  MessageType.quick_reply: 'quick_reply',
};
