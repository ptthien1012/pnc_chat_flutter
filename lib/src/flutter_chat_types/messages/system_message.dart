import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../user.dart' show User;

part 'system_message.g.dart';

/// A class that represents a system message (anything around chat management). Use [metadata] to store anything
/// you want.
@JsonSerializable()
@immutable
abstract class SystemMessage extends Message {
  /// Creates a custom message.
   SystemMessage._({
    // super.author = const User(id: 'system'),
    super.senderType,
    super.id,
    super.metadata,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    super.status,
    this.text,
    MessageType? type,
    super.source,
    super.isAuthor = false,
  }) : super(type: type ?? MessageType.system);

   factory SystemMessage({
    // User author,
    int? senderType,
    String? id,
    Map<String, dynamic>? metadata,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    Status? status,
    String? text,
    MessageType? type,
    dynamic source,
  }) = _SystemMessage;

  /// Creates a custom message from a map (decoded JSON).
  factory SystemMessage.fromJson(Map<String, dynamic> json) =>
      _$SystemMessageFromJson(json);

  /// System message content (could be text or translation key).
  String? text;

  /// Equatable props.
  @override
  List<Object?> get props => [
        // author,
        senderType,
        id,
        metadata,
        created_time,
        repliedMessage,
        content,
        showStatus,
        status,
        text,
        source,
      ];

  @override
  Message copyWith({
    // User? author,
    int? senderType,
    String? id,
    Map<String, dynamic>? metadata,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    Status? status,
    String? text,
    dynamic source,
    bool? isAuthor,
  });

  /// Converts a custom message to the map representation,
  /// encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$SystemMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _SystemMessage extends SystemMessage {
   _SystemMessage({
    // super.author,
    super.senderType,
    super.id,
    super.metadata,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    super.status,
    super.text,
    super.type,
    super.source,
  }) : super._();

  @override
  Message copyWith({
    User? author,
    dynamic senderType = _Unset,
    String? id,
    dynamic metadata = _Unset,
    dynamic created_time = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic content,
    dynamic showStatus = _Unset,
    dynamic status = _Unset,
    String? text,
    dynamic source = _Unset,
    dynamic isAuthor,
  }) =>
      _SystemMessage(
        // author: author ?? this.author,
        senderType: senderType == _Unset ? this.senderType : senderType as int?,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        created_time:
            created_time == _Unset ? this.created_time : created_time as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        content: content == _Unset ? this.content : content as Content?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        status: status == _Unset ? this.status : status as Status?,
        text: text ?? this.text,
        source: source == _Unset ? this.source : source as dynamic,
      );
}

class _Unset {}
