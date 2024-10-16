import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../preview_data.dart' show PreviewData;
import '../user.dart' show User;
import 'partial_text.dart';

part 'payload_message.g.dart';

/// A class that represents text message.
@JsonSerializable()
@immutable
abstract class PayloadMessage extends Message {
  /// Creates a text message.
   PayloadMessage._({
    // required super.author,
    super.senderType,
    super.id,
    super.metadata,
    this.previewData,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    super.status,
     this.text,
    MessageType? type,
    super.source,
    super.isAuthor,
  }) : super(type: type ?? MessageType.text);

   factory PayloadMessage({
    // required User author,
    int? senderType,
    String? id,
    Map<String, dynamic>? metadata,
    PreviewData? previewData,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    Status? status,
    String? text,
    MessageType? type,
    dynamic source,
    bool? isAuthor,
  }) = _PayloadMessage;

  /// Creates a text message from a map (decoded JSON).
  factory PayloadMessage.fromJson(Map<String, dynamic> json) =>
      _$PayloadMessageFromJson(json);

  /// Creates a full text message from a partial one.
  factory PayloadMessage.fromPartial({
    // required User author,
    int? senderType,
    String? id,
    PartialText? partialText,
    String? created_time,
    Content? content,
    bool? showStatus,
    Status? status,
    dynamic source,
    bool? isAuthor,
  }) =>
      _PayloadMessage(
        // author: author,
        senderType: senderType,
        id: id,
        metadata: partialText?.metadata,
        previewData: partialText?.previewData,
        created_time: created_time,
        repliedMessage: partialText?.repliedMessage,
        content: content,
        showStatus: showStatus ?? false,
        status: status,
        text: partialText?.text ?? '',
        type: MessageType.text,
        source: source,
        isAuthor: isAuthor ?? false,
      );

  /// See [PreviewData].
  final PreviewData? previewData;

  /// User's message.
  final String? text;

  /// Equatable props.
  @override
  List<Object?> get props => [
        // author,
        senderType,
        id,
        metadata,
        previewData,
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
    PreviewData? previewData,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    Status? status,
    String? text,
    dynamic source,
    bool? isAuthor,
  });

  /// Converts a text message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$PayloadMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _PayloadMessage extends PayloadMessage {
   _PayloadMessage({
    // required super.author,
    super.senderType,
    super.id,
    super.metadata,
    super.previewData,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    super.status,
    super.text,
    super.type,
    super.source,
    super.isAuthor,
  }) : super._();

  @override
  Message copyWith({
    // User? author,
    dynamic senderType = _Unset,
    String? id,
    dynamic metadata = _Unset,
    dynamic previewData = _Unset,
    dynamic created_time = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic content,
    dynamic showStatus = _Unset,
    dynamic status = _Unset,
    String? text,
    dynamic source = _Unset,
    bool? isAuthor,
  }) =>
      _PayloadMessage(
        // author: author ?? this.author,
        senderType: senderType == _Unset ? this.senderType : senderType as int?,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
        previewData: previewData == _Unset
            ? this.previewData
            : previewData as PreviewData?,
        created_time: created_time == _Unset
            ? this.created_time
            : created_time as String?,
        repliedMessage: repliedMessage == _Unset
            ? this.repliedMessage
            : repliedMessage as Message?,
        content: content == _Unset ? this.content : content as Content?,
        showStatus:
            showStatus == _Unset ? this.showStatus : showStatus as bool?,
        status: status == _Unset ? this.status : status as Status?,
        text: text ?? this.text,
        source: source == _Unset ? this.source : source as dynamic,
        isAuthor: isAuthor ?? this.isAuthor,
      );
}

class _Unset {}
