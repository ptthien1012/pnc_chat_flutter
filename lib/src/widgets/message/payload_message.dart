// import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_link_previewer/flutter_link_previewer.dart'
// show LinkPreview, regexEmail, regexLink;
import 'package:pnc_chat_flutter/src/flutter_chat_types/flutter_chat_types.dart'
    as types;

import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../flutter_chat_types/message.dart';
import '../../models/emoji_enlargement_behavior.dart';
import '../../models/pattern_style.dart';
import '../../util.dart';
import '../state/inherited_chat_theme.dart';
import '../state/inherited_user.dart';

/// A class that represents text message widget with optional link preview.
class PayloadMessage extends StatelessWidget {
  /// Creates a text message widget from a [types.PayloadMessage] class.
  const PayloadMessage({
    super.key,
    required this.message,
    required this.onPayload,
  });

  final void Function(ContentButton contendButton) onPayload;

  /// [types.PayloadMessage].
  final types.PayloadMessage message;

  /// This is to allow custom user name builder
  /// By using this we can fetch newest user info based on id
  // final Widget Function(String userId)? nameBuilder;

  /// Show user name for the received message. Useful for a group chat.
  // final bool showName;

  @override
  Widget build(BuildContext context) {
    final user = InheritedUser.of(context).user;
    final width = MediaQuery.of(context).size.width;

    return _textWidgetBuilder(user, context);
  }

  Widget _textWidgetBuilder(
    types.User user,
    BuildContext context,
  ) {
    final theme = InheritedChatTheme.of(context).theme;
    final bodyLinkTextStyle = message.isAuthor ?? false
        ? InheritedChatTheme.of(context).theme.sentMessageBodyLinkTextStyle
        : InheritedChatTheme.of(context).theme.receivedMessageBodyLinkTextStyle;
    final bodyTextStyle = message.isAuthor ?? false
        ? theme.sentMessageBodyTextStyle
        : theme.receivedMessageBodyTextStyle;
    final boldTextStyle = message.isAuthor ?? false
        ? theme.sentMessageBodyBoldTextStyle
        : theme.receivedMessageBodyBoldTextStyle;
    final codeTextStyle = message.isAuthor ?? false
        ? theme.sentMessageBodyCodeTextStyle
        : theme.receivedMessageBodyCodeTextStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (showName)
        // nameBuilder?.call(message.author.id) ??
        // UserName(author: message.author),
        PayloadMessageText(
          bodyLinkTextStyle: bodyLinkTextStyle,
          bodyTextStyle: bodyTextStyle,
          boldTextStyle: boldTextStyle,
          codeTextStyle: codeTextStyle,
          text: message.content?.text ?? message.text,
          content: message.content,
          onPayload: onPayload,
        ),
      ],
    );
  }
}

/// Widget to reuse the markdown capabilities, e.g., for previews.
class PayloadMessageText extends StatelessWidget {
  const PayloadMessageText({
    super.key,
    this.bodyLinkTextStyle,
    required this.bodyTextStyle,
    this.boldTextStyle,
    this.codeTextStyle,
    this.maxLines,
    this.options = const PayloadMessageOptions(),
    this.overflow = TextOverflow.clip,
    this.text,
    this.content,
    required this.onPayload,
  });

  final void Function(ContentButton contendButton) onPayload;

  /// Style to apply to anything that matches a link.
  final TextStyle? bodyLinkTextStyle;

  /// Regular style to use for any unmatched text. Also used as basis for the fallback options.
  final TextStyle bodyTextStyle;

  /// Style to apply to anything that matches bold markdown.
  final TextStyle? boldTextStyle;

  /// Style to apply to anything that matches code markdown.
  final TextStyle? codeTextStyle;

  /// See [ParsedText.maxLines].
  final int? maxLines;

  /// See [PayloadMessage.options].
  final PayloadMessageOptions options;

  /// See [ParsedText.overflow].
  final TextOverflow overflow;

  /// Text that is shown as markdown.
  final String? text;
  final Content? content;

  @override
  Widget build(BuildContext context) => _buildWidgetText(context);
  Widget _buildWidgetText(BuildContext context) {
    final theme = InheritedChatTheme.of(context).theme;
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: theme.messageInsetsHorizontal,
                vertical: theme.messageInsetsVertical),
            child: _buildParsedTextWidget(context)),
        content != null
            ? Column(
                children: [
                  const SizedBox(height: 10),
                  ..._buildListButton(content!)
                ],
              )
            : const SizedBox()
      ],
    );
  }

  List<Widget> _buildListButton(Content content) {
    final listButton = <Widget>[];
    if (content.buttons != null) {
      final numberButton = content.buttons!.length;
      for (var i = 0; i < numberButton; i++) {
        listButton.add(const Divider(
          color: Color(0xffc6cbd2),
          height: 0,
        ));
        listButton.add(buildSingleButton(i));
      }
    }
    return listButton;
  }

  Widget buildSingleButton(int index) => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          padding: EdgeInsets.zero,
          //  backgroundColor: Colors.white // foreground
        ),
        onPressed: () async {
          await _actionPressed(index);
        },
        child: Text(content?.buttons?[index].title ?? ''),
      );

  Future<void> _actionPressed(int index) async {
    switch (content!.buttons![index].actionType) {
      case UserAction.payload:
        onPayload(content!.buttons![index]);
        // _sendMessageChatbot(content!.buttons![index]);
        break;
      case UserAction.url:
        final url = Uri.parse(content!.buttons![index].url!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
        break;
      case UserAction.webview:
        final url = Uri.parse(content!.buttons![index].webview!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
        break;
      case UserAction.phoneCall:
        break;
      default:
    }
  }

  Widget _buildParsedTextWidget(BuildContext context) => ParsedText(
        parse: [
          ...options.matchers,
          MatchText(
            onTap: (mail) async {
              final url = Uri(scheme: 'mailto', path: mail);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
            pattern: 'regexEmail',
            style: bodyLinkTextStyle ??
                bodyTextStyle.copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
          MatchText(
            onTap: (urlText) async {
              final protocolIdentifierRegex = RegExp(
                r'^((http|ftp|https):\/\/)',
                caseSensitive: false,
              );
              if (!urlText.startsWith(protocolIdentifierRegex)) {
                urlText = 'https://$urlText';
              }
              if (options.onLinkPressed != null) {
                options.onLinkPressed!(urlText);
              } else {
                final url = Uri.tryParse(urlText);
                if (url != null && await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                }
              }
            },
            pattern: 'regexLink',
            type: ParsedType.URL,
            style: bodyLinkTextStyle ??
                bodyTextStyle.copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
          MatchText(
            pattern: PatternStyle.bold.pattern,
            style: boldTextStyle ??
                bodyTextStyle.merge(PatternStyle.bold.textStyle),
            renderText: ({required String str, required String pattern}) => {
              'display': str.replaceAll(
                PatternStyle.bold.from,
                PatternStyle.bold.replace,
              ),
            },
          ),
          MatchText(
            pattern: PatternStyle.italic.pattern,
            style: bodyTextStyle.merge(PatternStyle.italic.textStyle),
            renderText: ({required String str, required String pattern}) => {
              'display': str.replaceAll(
                PatternStyle.italic.from,
                PatternStyle.italic.replace,
              ),
            },
          ),
          MatchText(
            pattern: PatternStyle.lineThrough.pattern,
            style: bodyTextStyle.merge(PatternStyle.lineThrough.textStyle),
            renderText: ({required String str, required String pattern}) => {
              'display': str.replaceAll(
                PatternStyle.lineThrough.from,
                PatternStyle.lineThrough.replace,
              ),
            },
          ),
          MatchText(
            pattern: PatternStyle.code.pattern,
            style: codeTextStyle ??
                bodyTextStyle.merge(PatternStyle.code.textStyle),
            renderText: ({required String str, required String pattern}) => {
              'display': str.replaceAll(
                PatternStyle.code.from,
                PatternStyle.code.replace,
              ),
            },
          ),
        ],
        maxLines: maxLines,
        overflow: overflow,
        regexOptions: const RegexOptions(multiLine: true, dotAll: true),
        selectable: options.isTextSelectable,
        style: bodyTextStyle,
        text: text ?? '',
        textWidthBasis: TextWidthBasis.longestLine,
      );
}

@immutable
class PayloadMessageOptions {
  const PayloadMessageOptions({
    this.isTextSelectable = true,
    this.onLinkPressed,
    this.openOnPreviewImageTap = false,
    this.openOnPreviewTitleTap = false,
    this.matchers = const [],
  });

  /// Whether user can tap and hold to select a text content.
  final bool isTextSelectable;

  /// Custom link press handler.
  final void Function(String)? onLinkPressed;

  /// See [LinkPreview.openOnPreviewImageTap].
  final bool openOnPreviewImageTap;

  /// See [LinkPreview.openOnPreviewTitleTap].
  final bool openOnPreviewTitleTap;

  /// Additional matchers to parse the text.
  final List<MatchText> matchers;
}
