import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../user.dart' show User;

part 'unsupported_message.g.dart';

/// A class that represents unsupported message. Used for backwards
/// compatibility. If chat's end user doesn't update to a new version
/// where new message types are being sent, some of them will result
/// to unsupported.
@JsonSerializable()
@immutable
abstract class UnsupportedMessage extends Message {
  /// Creates an unsupported message.
   UnsupportedMessage._({
    // required super.author,
    super.senderType,
    required super.id,
    super.metadata,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    super.status,
    MessageType? type,
    super.source,
    required super.isAuthor,
  }) : super(type: type ?? MessageType.unsupported);

   factory UnsupportedMessage({
    // required User author,
    int? senderType,
    required String id,
    Map<String, dynamic>? metadata,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    Status? status,
    MessageType? type,
    dynamic source,
    required bool isAuthor,
  }) = _UnsupportedMessage;

  /// Creates an unsupported message from a map (decoded JSON).
  factory UnsupportedMessage.fromJson(Map<String, dynamic> json) =>
      _$UnsupportedMessageFromJson(json);

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
    dynamic source,
    bool? isAuthor,
  });

  /// Converts an unsupported message to the map representation,
  /// encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$UnsupportedMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _UnsupportedMessage extends UnsupportedMessage {
   _UnsupportedMessage({
    // required super.author,
    super.senderType,
    super.id,
    super.metadata,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    super.status,
    super.type,
    super.source,
    required super.isAuthor,
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
    dynamic source = _Unset,
    bool? isAuthor,
  }) =>
      _UnsupportedMessage(
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
        source: source == _Unset ? this.source : source as dynamic,
        isAuthor: isAuthor ?? this.isAuthor,
      );
}

class _Unset {}
