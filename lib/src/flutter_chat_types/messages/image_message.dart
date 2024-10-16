import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../user.dart' show User;
import 'partial_image.dart';

part 'image_message.g.dart';

/// A class that represents image message.
@JsonSerializable()
@immutable
abstract class ImageMessage extends Message {
  /// Creates an image message.
   ImageMessage._({
    // required super.author,
    super.senderType,
    this.height,
    super.id,
    super.metadata,
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
    this.width,
    super.isAuthor,
  }) : super(type: type ?? MessageType.image);

   factory ImageMessage({
    // required User author,
    int? senderType,
    double? height,
    String? id,
    Map<String, dynamic>? metadata,
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
    double? width,
    bool? isAuthor,
  }) = _ImageMessage;

  /// Creates an image message from a map (decoded JSON).
  factory ImageMessage.fromJson(Map<String, dynamic> json) =>
      _$ImageMessageFromJson(json);

  /// Creates a full image message from a partial one.
  factory ImageMessage.fromPartial({
    // required User author,
    int? senderType,
    String? id,
    required PartialImage partialImage,
    String? created_time,
    Content? content,
    bool? showStatus,
    Status? status,
    dynamic source,
    bool? isAuthor,
  }) =>
      _ImageMessage(
        // author: author,
        senderType: senderType,
        height: partialImage.height,
        id: id,
        metadata: partialImage.metadata,
        name: partialImage.name,
        created_time: created_time,
        repliedMessage: partialImage.repliedMessage,
        content: content,
        showStatus: showStatus,
        size: partialImage.size,
        status: status,
        type: MessageType.image,
        source: source,
        uri: partialImage.uri,
        width: partialImage.width,
        isAuthor: isAuthor,
      );

  /// Image height in pixels.
  final double? height;

  /// The name of the image.
  final String? name;

  /// Size of the image in bytes.
  final num? size;

  /// The image source (either a remote URL or a local resource).
  final String? uri;

  /// Image width in pixels.
  final double? width;

  /// Equatable props.
  @override
  List<Object?> get props => [
        // author,
        senderType,
        height,
        id,
        metadata,
        name,
        created_time,
        repliedMessage,
        content,
        showStatus,
        size,
        status,
        source,
        uri,
        width,
      ];

  @override
  Message copyWith({
    // User? author,
    int? senderType,
    double? height,
    String? id,
    Map<String, dynamic>? metadata,
    String? name,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    num? size,
    Status? status,
    dynamic source,
    String? uri,
    double? width,
    bool? isAuthor,
  });

  /// Converts an image message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$ImageMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _ImageMessage extends ImageMessage {
   _ImageMessage({
    // required super.author,
    super.senderType,
    super.height,
    super.id,
    super.metadata,
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
    super.width,
    super.isAuthor,
  }) : super._();

  @override
  Message copyWith({
    // User? author,
    dynamic senderType = _Unset,
    dynamic height = _Unset,
    String? id,
    dynamic metadata = _Unset,
    String? name,
    dynamic created_time = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic content,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic source = _Unset,
    String? uri,
    dynamic width = _Unset,
    bool? isAuthor,
  }) =>
      _ImageMessage(
        // author: author ?? this.author,
        senderType: senderType == _Unset ? this.senderType : senderType as int?,
        height: height == _Unset ? this.height : height as double?,
        id: id ?? this.id,
        metadata: metadata == _Unset
            ? this.metadata
            : metadata as Map<String, dynamic>?,
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
        width: width == _Unset ? this.width : width as double?,
        isAuthor: isAuthor ?? this.isAuthor,
      );
}

class _Unset {}
