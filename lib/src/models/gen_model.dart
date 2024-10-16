// class Content {
//     Content({
//         this.buttons,
//         this.title,
//         this.contentBinary,
//         this.text,
//         this.url,
//         this.fileId,
//         this.fileName,
//         this.carouselCards,
//     });

//     List<ContentButton>? buttons;
//     String? title;
//     String? contentBinary;
//     String? text;
//     String? url;
//     String? fileId;
//     String? fileName;
//     List<CarouselCard>? carouselCards;

//     factory Content.fromJson(Map<String, dynamic> json) => Content(
//         buttons: List<ContentButton>.from(json['buttons'].map((x) => ContentButton.fromJson(x))),
//         title: json['title'],
//         contentBinary: json['content_binary'],
//         text: json['text'],
//         url: json['url'],
//         fileId: json['file_id'],
//         fileName: json['file_name'],
//         carouselCards: List<CarouselCard>.from(json['carousel_cards'].map((x) => CarouselCard.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         'buttons': List<dynamic>.from(buttons!.map((x) => x.toJson())),
//         'title': title,
//         'content_binary': contentBinary,
//         'text': text,
//         'url': url,
//         'file_id': fileId,
//         'file_name': fileName,
//         'carousel_cards': List<dynamic>.from(carouselCards!.map((x) => x.toJson())),
//     };
// }

// class ContentButton {
//     ContentButton({
//         this.title,
//         this.payload,
//         this.url,
//         this.phoneCall,
//         this.webview,
//     });

//     String? title;
//     String? payload;
//     String? url;
//     String? phoneCall;
//     String? webview;

//     factory ContentButton.fromJson(Map<String, dynamic> json) => ContentButton(
//         title: json['title'],
//         payload: json['payload'] == null ? null : json['payload'],
//         url: json['url'] == null ? null : json['url'],
//         phoneCall: json['phone_call'] == null ? null : json['phone_call'],
//         webview: json['webview'] == null ? null : json['webview'],
//     );

//     Map<String, dynamic> toJson() => {
//         'title': title,
//         'payload': payload == null ? null : payload,
//         'url': url == null ? null : url,
//         'phone_call': phoneCall == null ? null : phoneCall,
//         'webview': webview == null ? null : webview,
//     };
// }

// class CarouselCard {
//     CarouselCard({
//         this.title,
//         this.subtitle,
//         this.itemUrl,
//         this.imageUrl,
//         this.buttons,
//     });

//     String? title;
//     String? subtitle;
//     String? itemUrl;
//     String? imageUrl;
//     List<CarouselCardButton>? buttons;

//     factory CarouselCard.fromJson(Map<String, dynamic> json) => CarouselCard(
//         title: json['title'],
//         subtitle: json['subtitle'],
//         itemUrl: json['item_url'],
//         imageUrl: json['image_url'],
//         buttons: json['buttons'] == null ? null : List<CarouselCardButton>.from(json['buttons'].map((x) => CarouselCardButton.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         'title': title,
//         'subtitle': subtitle,
//         'item_url': itemUrl,
//         'image_url': imageUrl,
//         'buttons': buttons == null ? null : List<dynamic>.from(buttons!.map((x) => x.toJson())),
//     };
// }

// class CarouselCardButton {
//     CarouselCardButton({
//         this.title,
//         this.payload,
//     });

//     String? title;
//     String? payload;

//     factory CarouselCardButton.fromJson(Map<String, dynamic> json) => CarouselCardButton(
//         title: json['title'],
//         payload: json['payload'],
//     );

//     Map<String, dynamic> toJson() => {
//         'title': title,
//         'payload': payload,
//     };
// }

