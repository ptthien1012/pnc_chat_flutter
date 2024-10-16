import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pnc_chat_flutter/src/flutter_chat_types/flutter_chat_types.dart'
    as types;
import 'package:pnc_chat_flutter/src/widgets/transparent_image_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../flutter_chat_types/message.dart';

class CarouselMessage extends StatelessWidget {
  const CarouselMessage(
      {super.key, required this.message, required this.onPayload});

  /// [types.CarouselMessage].
  final types.CarouselMessage message;
  final void Function(ContentButton contendButton) onPayload;

  @override
  Widget build(BuildContext context) => Container(child: carouselWidget());

  Widget carouselWidget() => CarouselSlider(
      items: message.content!.carouselCards!
          .map((e) => Builder(
                builder: (BuildContext context) => GestureDetector(
                  onTap: () => _actionPressed(e),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(right: 10),
                    child: TransparentImageCard(
                      // contentPadding: const EdgeInsets.only(bottom: 100, left: 10),
                      contentMarginTop:
                          MediaQuery.of(context).size.width * 0.8 * 9 / 16 -
                              110,
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8 * 9 / 16,
                      imageProvider: NetworkImage(e.imageUrl!),
                      tags: [
                        _tag(e.imageSubCaption, () {}),
                      ],
                      title: _title(e.title),
                      description: _content(e.subtitle),
                    ),
                    // child: Stack(
                    // children: [
                    // Image.network(
                    // e.imageUrl!,
                    // fit: BoxFit.fill,
                    // ),
                    // e.title != null
                    // ? Positioned(
                    // bottom: 0,
                    // left: 0,
                    // child: Container(
                    // padding: const EdgeInsets.only(left: 16, top: 10),
                    // alignment: AlignmentDirectional.centerStart,
                    // child: Text(
                    // e.title!,
                    // style: const TextStyle(fontSize: 14),
                    // textWidthBasis: TextWidthBasis.longestLine,
                    // maxLines: 2,
                    // ),
                    // ),
                    // )
                    // : Container()
                    // ],
                    // ),
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
          // aspectRatio: 2 / 1,
          // viewportFraction: 0.8,
          enableInfiniteScroll: false,
          // onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
          disableCenter: false,
          padEnds: false));
  Future<void> _actionPressed(CarouselCard carouselCard) async {
    if (carouselCard.buttons == null) return;
    switch (carouselCard.buttons![0].actionType) {
      case UserAction.payload:
        var contentButton = ContentButton();
        contentButton.title = carouselCard.buttons![0].title;
        contentButton.payload = carouselCard.buttons![0].payload;
        onPayload(contentButton);
        break;
      case UserAction.url:
        var url = carouselCard.buttons![0].url!;
        var urlUri = Uri.parse(url);
        if (Platform.isAndroid) {
          if (await canLaunchUrl(urlUri)) {
            await launchUrl(urlUri,
                mode: LaunchMode.externalNonBrowserApplication);
          }
          // url = 'http://drive.google.com/viewer?embedded=true&url=$url';
        } else {
          if (await canLaunchUrl(urlUri)) {
            await launchUrl(urlUri);
          }
        }

        break;
      case UserAction.unknow:
        break;
      default:
    }
  }

  Widget _title(String? title) {
    return Text(
      title ?? '',
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
      maxLines: 1,
    );
  }

  Widget _content(String? content) {
    return Text(
      content ?? '',
      maxLines: 1,
      style: const TextStyle(fontSize: 14, color: Colors.white),
    );
  }

  Widget _footer({Color? color}) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(
            'assets/avatar.png',
          ),
          radius: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          'Super user',
          style: TextStyle(color: color),
        )),
        IconButton(onPressed: () {}, icon: const Icon(Icons.share))
      ],
    );
  }

  Widget _tag(String? tag, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          tag ?? '',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
