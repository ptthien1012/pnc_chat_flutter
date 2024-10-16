import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../user.dart' show User;
import 'partial_file.dart';

// part 'file_message.g.dart';

/// A class that represents file message.
@JsonSerializable()
@immutable
abstract class FileMessage extends Message {
  /// Creates a file message.
   FileMessage._({
    // required super.author,
    super.senderType,
    super.id,
    this.isLoading,
    super.metadata,
    this.mimeType,
    this.name,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    this.size,
    super.status,
    MessageType? type,
    super.source,
    this.uri,
    super.isAuthor ,

  }) : super(type: type ?? MessageType.file);

   factory FileMessage({
    // required User author,
    int? senderType,
    String? id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? name,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    num? size,
    Status? status,
    MessageType? type,
    dynamic source,
    String? uri,
    bool? isAuthor,
  }) = _FileMessage;

  /// Creates a file message from a map (decoded JSON).
  factory FileMessage.fromJson(Map<String, dynamic> json) =>  FileMessage(
     senderType: json['senderType'] as int?,
     id: json['id'] as String?,
     isLoading: json['isLoading'] as bool?,
     metadata: json['metadata'] as Map<String, dynamic>?,
     mimeType: json['mimeType'] as String?,
     name: json['name'] as String?,
     created_time: json['created_time'] as String?,
     repliedMessage: json['repliedMessage'] == null
         ? null
         : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
     content: json['content'] == null
         ? null
         : json['content'] is String ? Content.fromJson(jsonDecode(json['content']) as Map<String, dynamic>) : Content.fromJson(json['content'] as Map<String, dynamic>),
     showStatus: json['showStatus'] as bool?,
     size: json['size'] as num?,
     status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
     type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
     source: json['source'],
     uri: json['uri'] as String?,
     isAuthor: json['isAuthor'] as bool?,
   );

  /// Creates a full file message from a partial one.
  factory FileMessage.fromPartial({
    // required User author,
    int? senderType,
    String? id,
    bool? isLoading,
    required PartialFile partialFile,
    String? created_time,
    Content? content,
    bool? showStatus,
    Status? status,
    dynamic source,
    bool? isAuthor,
  }) =>
      _FileMessage(
        // author: author,
        senderType: senderType,
        id: id,
        isLoading: isLoading,
        metadata: partialFile.metadata,
        mimeType: partialFile.mimeType,
        name: partialFile.name,
        created_time: created_time,
        repliedMessage: partialFile.repliedMessage,
        content: content,
        showStatus: showStatus,
        size: partialFile.size,
        status: status,
        type: MessageType.file,
        source: source,
        uri: partialFile.uri,
        isAuthor: isAuthor,
      );

  /// Specify whether the message content is currently being loaded.
  final bool? isLoading;

  /// Media type.
  final String? mimeType;

  /// The name of the file.
  final String? name;

  /// Size of the file in bytes.
  final num? size;

  /// The file source (either a remote URL or a local resource).
  final String? uri;

  /// Equatable props.
  @override
  List<Object?> get props => [
        // author,
        senderType,
        id,
        isLoading,
        metadata,
        mimeType,
        name,
        created_time,
        repliedMessage,
        content,
        showStatus,
        size,
        status,
        source,
        uri,
      ];

  @override
  Message copyWith({
    // User? author,
    int? senderType,
    String? id,
    bool? isLoading,
    Map<String, dynamic>? metadata,
    String? mimeType,
    String? name,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    num? size,
    Status? status,
    dynamic source,
    String? uri,
    bool? isAuthor,
  });

  /// Converts a file message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$FileMessageToJson(this);

  // FileMessage _$FileMessageFromJson(Map<String, dynamic> json) => FileMessage(
      // senderType: json['senderType'] as int?,
      // id: json['id'] as String?,
      // isLoading: json['isLoading'] as bool?,
      // metadata: json['metadata'] as Map<String, dynamic>?,
      // mimeType: json['mimeType'] as String?,
      // name: json['name'] as String?,
      // created_time: json['created_time'] as String?,
      // repliedMessage: json['repliedMessage'] == null
          // ? null
          // : Message.fromJson(json['repliedMessage'] as Map<String, dynamic>),
      // content: json['content'] == null
          // ? null
          // : Content.fromJson(json['content'] as Map<String, dynamic>),
      // showStatus: json['showStatus'] as bool?,
      // size: json['size'] as num?,
      // status: $enumDecodeNullable(_$StatusEnumMap, json['status']),
      // type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      // source: json['source'],
      // uri: json['uri'] as String?,
      // isAuthor: json['isAuthor'] as bool?,
    // );

Map<String, dynamic> _$FileMessageToJson(FileMessage instance) =>
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
      'isLoading': instance.isLoading,
      'mimeType': instance.mimeType,
      'name': instance.name,
      'size': instance.size,
      'uri': instance.uri,
    };

static const _$StatusEnumMap = {
  Status.delivered: 'delivered',
  Status.error: 'error',
  Status.seen: 'seen',
  Status.sending: 'sending',
  Status.sent: 'sent',
};

static const _$MessageTypeEnumMap = {
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

}

/// A utility class to enable better copyWith.
class _FileMessage extends FileMessage {
   _FileMessage({
    // required super.author,
    super.senderType,
    super.id,
    super.isLoading,
    super.metadata,
    super.mimeType,
     super.name,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
     super.size,
    super.status,
    super.type,
    super.source,
     super.uri,
    super.isAuthor,
  }) : super._();

  @override
  Message copyWith({
    // User? author,
    dynamic senderType = _Unset,
    dynamic height = _Unset,
    String? id,
    dynamic isLoading = _Unset,
    dynamic metadata = _Unset,
    dynamic mimeType = _Unset,
    String? name,
    dynamic created_time = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic content = _Unset,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic source = _Unset,
    String? uri,
    dynamic width = _Unset,
    bool? isAuthor,
  }) =>
      _FileMessage(
        // author: author ?? this.author,
        senderType: senderType == _Unset ? this.senderType : senderType as int?,
        id: id ?? this.id,
        isLoading: isLoading == _Unset ? this.isLoading : isLoading as bool?,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        mimeType: mimeType == _Unset ? this.mimeType : mimeType as String?,
        name: name ?? this.name,
        created_time:
            created_time == _Unset ? this.created_time : created_time as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        content: content == _Unset ? this.content : content as Content?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        size: size ?? this.size,
        status: status == _Unset ? this.status : status as Status?,
        source: source == _Unset ? this.source : source as dynamic,
        uri: uri ?? this.uri,
        isAuthor: isAuthor ?? this.isAuthor,
      );
      
}

class _Unset {}
