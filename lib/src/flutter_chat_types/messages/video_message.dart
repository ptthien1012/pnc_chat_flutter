import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../user.dart' show User;
import 'partial_video.dart';

part 'video_message.g.dart';

/// A class that represents video message.
@JsonSerializable()
@immutable
abstract class VideoMessage extends Message {
  /// Creates a video message.
   VideoMessage._({
    // required super.author,
    super.senderType,
    this.height,
    required super.id,
    super.metadata,
    required this.name,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    required this.size,
    super.status,
    MessageType? type,
    super.source,
    required this.uri,
    this.width,
        required super.isAuthor ,

  }) : super(type: type ?? MessageType.video);

   factory VideoMessage({
    // required User author,
    int? senderType,
    double? height,
    required String id,
    Map<String, dynamic>? metadata,
    required String name,
    String? created_time,
    Message? repliedMessage,
    Content? content,
    bool? showStatus,
    required num size,
    Status? status,
    MessageType? type,
    dynamic source,
    required String uri,
    double? width,
    required bool isAuthor,
  }) = _VideoMessage;

  /// Creates a video message from a map (decoded JSON).
  factory VideoMessage.fromJson(Map<String, dynamic> json) =>
      _$VideoMessageFromJson(json);

  /// Creates a full video message from a partial one.
  factory VideoMessage.fromPartial({
    // required User author,
    int? senderType,
    required String id,
    required PartialVideo partialVideo,
    String? created_time,
    Content? content,
    bool? showStatus,
    Status? status,
    dynamic source,
        required bool isAuthor ,

  }) =>
      _VideoMessage(
        // author: author,
        senderType: senderType,
        height: partialVideo.height,
        id: id,
        metadata: partialVideo.metadata,
        name: partialVideo.name,
        created_time: created_time,
        repliedMessage: partialVideo.repliedMessage,
        content: content,
        showStatus: showStatus,
        size: partialVideo.size,
        status: status,
        type: MessageType.video,
        source: source,
        uri: partialVideo.uri,
        width: partialVideo.width,
        isAuthor: isAuthor,
      );

  /// Video height in pixels.
  final double? height;

  /// The name of the video.
  final String name;

  /// Size of the video in bytes.
  final num size;

  /// The video source (either a remote URL or a local resource).
  final String uri;

  /// Video width in pixels.
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

  /// Converts an video message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$VideoMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _VideoMessage extends VideoMessage {
   _VideoMessage({
    // required super.author,
    super.senderType,
    super.height,
    required super.id,
    super.metadata,
    required super.name,
    super.created_time,
    super.repliedMessage,
    super.content,
    super.showStatus,
    required super.size,
    super.status,
    super.type,
    super.source,
    required super.uri,
    super.width,
    required super.isAuthor,
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
      _VideoMessage(
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
