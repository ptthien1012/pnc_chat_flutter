import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../message.dart';
import '../user.dart' show User;
import 'partial_audio.dart';

part 'audio_message.g.dart';

/// A class that represents audio message.
@JsonSerializable()
@immutable
abstract class AudioMessage extends Message {
  /// Creates an audio message.
   AudioMessage._({
    // required super.author,
    super.senderType,
    required this.duration,
    super.id,
    super.metadata,
    this.mimeType,
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
    this.waveForm,
    required super.isAuthor,
  }) : super(type: type ?? MessageType.audio);

   factory AudioMessage({
    // required User author,
    int? senderType,
    required Duration duration,
    required String id,
    Map<String, dynamic>? metadata,
    String? mimeType,
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
    List<double>? waveForm,
    required bool isAuthor,
  }) = _AudioMessage;

  /// Creates an audio message from a map (decoded JSON).
  factory AudioMessage.fromJson(Map<String, dynamic> json) =>
      _$AudioMessageFromJson(json);

  /// Creates a full audio message from a partial one.
  factory AudioMessage.fromPartial({
    // required User author,
    int? senderType,
    required String id,
    required PartialAudio partialAudio,
    String? created_time,
    Content? content,
    bool? showStatus,
    Status? status,
    dynamic source,
    required bool isAuthor,
  }) =>
      _AudioMessage(
        // author: author,
        senderType: senderType,
        duration: partialAudio.duration,
        id: id,
        metadata: partialAudio.metadata,
        mimeType: partialAudio.mimeType,
        name: partialAudio.name,
        created_time: created_time,
        repliedMessage: partialAudio.repliedMessage,
        content: content,
        showStatus: showStatus,
        size: partialAudio.size,
        status: status,
        type: MessageType.audio,
        source: source,
        uri: partialAudio.uri,
        waveForm: partialAudio.waveForm,
        isAuthor: isAuthor,
      );

  /// The length of the audio.
  final Duration duration;

  /// Media type of the audio file.
  final String? mimeType;

  /// The name of the audio.
  final String name;

  /// Size of the audio in bytes.
  final num size;

  /// The audio file source (either a remote URL or a local resource).
  final String uri;

  /// Wave form represented as a list of decibel levels.
  final List<double>? waveForm;

  /// Equatable props.
  @override
  List<Object?> get props => [
        // author,
        senderType,
        duration,
        id,
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
        waveForm,
      ];

  @override
  Message copyWith({
    // User? author,
    int? senderType,
    Duration? duration,
    String? id,
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
    List<double>? waveForm,
    bool? isAuthor,
  });

  /// Converts an audio message to the map representation, encodable to JSON.
  @override
  Map<String, dynamic> toJson() => _$AudioMessageToJson(this);
}

/// A utility class to enable better copyWith.
class _AudioMessage extends AudioMessage {
   _AudioMessage({
    // required super.author,
    super.senderType,
    required super.duration,
    required super.id,
    super.metadata,
    super.mimeType,
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
    super.waveForm,
    required super.isAuthor,
  }) : super._();

  @override
  Message copyWith({
    // User? author,
    dynamic senderType = _Unset,
    Duration? duration,
    String? id,
    dynamic metadata = _Unset,
    dynamic mimeType = _Unset,
    String? name,
    dynamic created_time = _Unset,
    dynamic repliedMessage = _Unset,
    dynamic content,
    dynamic showStatus = _Unset,
    num? size,
    dynamic status = _Unset,
    dynamic source = _Unset,
    String? uri,
    dynamic waveForm = _Unset,
    bool? isAuthor,
  }) =>
      _AudioMessage(
        // author: author ?? this.author,
        senderType: senderType == _Unset ? this.senderType : senderType as int?,
        duration: duration ?? this.duration,
        id: id ?? this.id,
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
        waveForm:
            waveForm == _Unset ? this.waveForm : waveForm as List<double>?,
        isAuthor: isAuthor ?? this.isAuthor,
      );
}

class _Unset {}
