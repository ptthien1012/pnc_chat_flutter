class SocketModel {
  final int? senderType;
  final String? id;
  final Content? content;
  final String? type;
  final String? created_time;
  final int? source;
  const SocketModel(
      {this.senderType,
      this.id,
      this.content,
      this.type,
      this.created_time,
      this.source});
  SocketModel copyWith(
      {int? senderType,
      String? id,
      Content? content,
      String? type,
      String? created_time,
      int? source}) {
    return SocketModel(
        senderType: senderType ?? this.senderType,
        id: id ?? this.id,
        content: content ?? this.content,
        type: type ?? this.type,
        created_time: created_time ?? this.created_time,
        source: source ?? this.source);
  }

  Map<String, Object?> toJson() {
    return {
      'senderType': senderType,
      'id': id,
      'content': content?.toJson(),
      'type': type,
      'created_time': created_time,
      'source': source
    };
  }

  static SocketModel fromJson(Map<String, Object?> json) {
    return SocketModel(
        senderType:
            json['sender_type'] == null ? null : json['sender_type'] as int,
        id: json['_id'] == null ? null : json['_id'] as String,
        content: json['content'] == null
            ? null
            : Content.fromJson(json['content'] as Map<String, Object?>),
        type: json['type'] == null ? null : json['type'] as String,
        created_time: json['created_time'] == null
            ? null
            : json['created_time'] as String,
        source: json['source'] == null ? null : json['source'] as int);
  }

  @override
  String toString() {
    return '''SocketModel(
                senderType:$senderType,
id:$id,
content:${content.toString()},
type:$type,
created_time:$created_time,
source:$source
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is SocketModel &&
        other.runtimeType == runtimeType &&
        other.senderType == senderType &&
        other.id == id &&
        other.content == content &&
        other.type == type &&
        other.created_time == created_time &&
        other.source == source;
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType, senderType, id, content, type, created_time, source);
  }
}

class Content {
  final List<Buttons>? buttons;
  final String? text;
  final String? title;
  final String? url;
  final String? contentBinary;
  const Content({this.buttons, this.text, this.title, this.url, this.contentBinary});
  Content copyWith({List<Buttons>? buttons, String? text, String? title, String? url, String? contentBinary}) {
    return Content(buttons: buttons ?? this.buttons, text: text ?? this.text, title: title ?? this.title, url: url ?? this.url, contentBinary: contentBinary ?? this.contentBinary);
  }

  Map<String, Object?> toJson() {
    return {
      'buttons':
          buttons?.map<Map<String, dynamic>>((data) => data.toJson()).toList(),
      'text': text,
      'title': title,
      'url': url,
      'content_binary': contentBinary
    };
  }

  static Content fromJson(Map<String, Object?> json) {
    return Content(
        buttons: json['buttons'] == null
            ? null
            : (json['buttons'] as List)
                .map<Buttons>(
                    (data) => Buttons.fromJson(data as Map<String, Object?>))
                .toList(),
        text: json['text'] == null ? null : json['text'] as String,
        title: json['title'] == null ? null : json['title'] as String,
        url: json['url'] == null ? null : json['url'] as String,
        contentBinary: json['content_binary'] == null ? null : json['content_binary'] as String,
        );
  }

  @override
  String toString() {
    return '''Content(
                buttons:${buttons.toString()},
text:$text, title:$title, url:$url, content_binary:$contentBinary
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Content &&
        other.runtimeType == runtimeType &&
        other.buttons == buttons &&
        other.text == text;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, buttons, text);
  }
}

class Buttons {
  final String? title;
  final String? payload;
  final String? webview;
  const Buttons({this.title, this.payload, this.webview});
  Buttons copyWith({String? title, String? payload, String? webview}) {
    return Buttons(
        title: title ?? this.title,
        payload: payload ?? this.payload,
        webview: webview ?? this.webview);
  }

  Map<String, Object?> toJson() {
    return {'title': title, 'payload': payload, 'webview': webview};
  }

  static Buttons fromJson(Map<String, Object?> json) {
    return Buttons(
        title: json['title'] == null ? null : json['title'] as String,
        payload: json['payload'] == null ? null : json['payload'] as String,
        webview: json['webview'] == null ? null : json['webview'] as String);
  }

  @override
  String toString() {
    return '''Buttons(
                title:$title,
payload:$payload,
webview:$webview
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Buttons &&
        other.runtimeType == runtimeType &&
        other.title == title &&
        other.payload == payload &&
        other.webview == webview;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, title, payload, webview);
  }
}
