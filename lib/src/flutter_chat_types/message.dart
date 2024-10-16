import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pnc_chat_flutter/src/flutter_chat_types/messages/payload_message.dart';
import 'package:pnc_chat_flutter/src/flutter_chat_types/messages/typing_message.dart';

import 'messages/audio_message.dart';
import 'messages/carousel_message.dart';
import 'messages/custom_message.dart';
import 'messages/file_message.dart';
import 'messages/image_message.dart';
import 'messages/quick_reply_message.dart';
import 'messages/system_message.dart';
import 'messages/text_message.dart';
import 'messages/unsupported_message.dart';
import 'messages/video_message.dart';

/// All possible message types.
enum MessageType {
  audio,
  custom,
  file,
  image,
  system,
  text,
  unsupported,
  video,
  carousel,
  payload,
  typing,
  quick_reply
}

/// All possible statuses message can have.
enum Status { delivered, error, seen, sending, sent }

/// An abstract class that contains all variables and methods
/// every message will have.
@immutable
abstract class Message extends Equatable {
  Message({
    // required this.author,
    this.senderType,
    this.id,
    this.metadata,
    this.created_time,
    this.repliedMessage,
    this.content,
    this.showStatus,
    this.status,
    required this.type,
    this.source,
    this.isAuthor,
  });

  /// Creates a particular message from a map (decoded JSON).
  /// Type is determined by the `type` field.
  factory Message.fromJson(Map<String, dynamic> json) {
    final type = MessageType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => MessageType.unsupported,
    );

    switch (type) {
      case MessageType.audio:
        return AudioMessage.fromJson(json);
      case MessageType.custom:
        return CustomMessage.fromJson(json);
      case MessageType.file:
        return FileMessage.fromJson(json);
      case MessageType.image:
        return ImageMessage.fromJson(json);
      case MessageType.system:
        return SystemMessage.fromJson(json);
      case MessageType.text:
        return TextMessage.fromJson(json);
      case MessageType.unsupported:
        return UnsupportedMessage.fromJson(json);
      case MessageType.video:
        return VideoMessage.fromJson(json);
      case MessageType.carousel:
        return CarouselMessage.fromJson(json);
      case MessageType.quick_reply:
        return QuickReplyMessage.fromJson(json);
      case MessageType.payload:
        return PayloadMessage.fromJson(json);
      case MessageType.typing:
      return TypingMessage.fromJson(json);
    }
  }

  /// User who sent this message.
  // final User author;

  /// Created message timestamp, in ms.
  final int? senderType;

  /// Unique ID of the message.
  String? id;

  /// Additional custom metadata or attributes related to the message.
  final Map<String, dynamic>? metadata;

  /// Unique ID of the message received from the backend.
  String? created_time;

  /// Message that is being replied to with the current message.
  final Message? repliedMessage;

  /// ID of the room where this message is sent.
  Content? content;

  /// Show status or not.
  final bool? showStatus;

  bool? isAuthor;

  /// Message [Status].
  final Status? status;

  /// [MessageType].
  final MessageType type;

  /// Updated message timestamp, in ms.
  dynamic source;

  /// Creates a copy of the message with an updated data.
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

  /// Converts a particular message to the map representation, serializable to JSON.
  Map<String, dynamic> toJson();
}

enum UserAction { payload, phoneCall, url, webview, unknow }

class Content {
  Content({
    this.buttons,
    this.title,
    this.contentBinary,
    this.text,
    this.url,
    this.fileId,
    this.fileName,
    this.carouselCards,
  });

  List<ContentButton>? buttons;
  String? title;
  String? contentBinary;
  String? text;
  String? url;
  String? fileId;
  String? fileName;
  List<CarouselCard>? carouselCards;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        buttons: json['buttons'] == null
            ? null
            : List<ContentButton>.from(
                json['buttons'].map((x) => ContentButton.fromJson(x))),
        title: json['title'],
        contentBinary: json['content_binary'],
        text: json['text'],
        url: json['url'],
        fileId: json['file_id'],
        fileName: json['file_name'],
        carouselCards: json['carousel_cards'] == null
            ? null
            : List<CarouselCard>.from(
                json['carousel_cards'].map((x) => CarouselCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'buttons': List<dynamic>.from(buttons!.map((x) => x.toJson())),
        'title': title,
        'content_binary': contentBinary,
        'text': text,
        'url': url,
        'file_id': fileId,
        'file_name': fileName,
        'carousel_cards':
            List<dynamic>.from(carouselCards!.map((x) => x.toJson())),
      };
}

class ContentButton {
  ContentButton(
      {this.title,
      this.payload,
      this.url,
      this.phoneCall,
      this.webview,
      this.actionType});
  UserAction? actionType;
  String? title;
  String? payload;
  String? url;
  String? phoneCall;
  String? webview;

  factory ContentButton.fromJson(Map<String, dynamic> json) => ContentButton(
        title: json['title'],
        payload: json['payload'] == null ? null : json['payload'],
        url: json['url'] == null ? null : json['url'],
        phoneCall: json['phone_call'] == null ? null : json['phone_call'],
        webview: json['webview'] == null ? null : json['webview'],
        actionType: json['payload'] != null
            ? UserAction.payload
            : json['url'] != null
                ? UserAction.url
                : json['phone_call'] != null
                    ? UserAction.phoneCall
                    : json['webview'] != null
                        ? UserAction.webview
                        : UserAction.unknow,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'payload': payload == null ? null : payload,
        'url': url == null ? null : url,
        'phone_call': phoneCall == null ? null : phoneCall,
        'webview': webview == null ? null : webview,
      };
}

class CarouselCard {
  CarouselCard({
    this.title,
    this.subtitle,
    this.itemUrl,
    this.imageUrl,
    this.buttons,
    this.imageSubCaption,
  });

  String? title;
  String? subtitle;
  String? itemUrl;
  String? imageUrl;
  String? imageSubCaption;
  List<CarouselCardButton>? buttons;

  factory CarouselCard.fromJson(Map<String, dynamic> json) => CarouselCard(
        title: json['title'],
        imageSubCaption: json['image_sub_caption'],
        subtitle: json['subtitle'],
        itemUrl: json['item_url'],
        imageUrl: json['image_url'],
        buttons: json['buttons'] == null
            ? null
            : List<CarouselCardButton>.from(
                json['buttons'].map((x) => CarouselCardButton.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'image_sub_caption': imageSubCaption,
        'subtitle': subtitle,
        'item_url': itemUrl,
        'image_url': imageUrl,
        'buttons': buttons == null
            ? null
            : List<dynamic>.from(buttons!.map((x) => x.toJson())),
      };
}

class CarouselCardButton {
  CarouselCardButton({
    this.title,
    this.payload,
    this.actionType,
    this.url,
  });

  String? title;
  String? payload;
  String? url;
  UserAction? actionType;

  factory CarouselCardButton.fromJson(Map<String, dynamic> json) =>
      CarouselCardButton(
        title: json['title'],
        payload: json['payload'],
        url: json['url'],
        actionType:
            json['payload'] != null ? UserAction.payload : json['url'] != null ? UserAction.url : UserAction.unknow,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'payload': payload,
        'url': url,
      };
}
