// import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:pnc_chat_flutter/src/flutter_link_previewer/flutter_link_previewer.dart'
    show LinkPreview, regexEmail, regexLink;
import 'package:pnc_chat_flutter/src/flutter_chat_types/flutter_chat_types.dart'
    as types;

import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../flutter_chat_types/message.dart';
import '../../models/emoji_enlargement_behavior.dart';
import '../../models/pattern_style.dart';
import '../state/inherited_chat_theme.dart';
import '../state/inherited_user.dart';

/// A class that represents text message widget with optional link preview.
class QuickReplyMessage extends StatelessWidget {
  /// Creates a text message widget from a [types.QuickReplyMessage] class.
  const QuickReplyMessage({
    super.key,
    required this.emojiEnlargementBehavior,
    required this.hideBackgroundOnEmojiMessages,
    required this.message,
    this.nameBuilder,
    this.onPreviewDataFetched,
    this.options = const QuickReplyMessageOptions(),
    required this.showName,
    required this.usePreviewData,
    this.userAgent,
  });

  /// See [Message.emojiEnlargementBehavior].
  final EmojiEnlargementBehavior emojiEnlargementBehavior;

  /// See [Message.hideBackgroundOnEmojiMessages].
  final bool hideBackgroundOnEmojiMessages;

  /// [types.QuickReplyMessage].
  final types.QuickReplyMessage message;

  /// This is to allow custom user name builder
  /// By using this we can fetch newest user info based on id
  final Widget Function(String userId)? nameBuilder;

  /// See [LinkPreview.onPreviewDataFetched].
  final void Function(types.QuickReplyMessage, types.PreviewData)?
      onPreviewDataFetched;

  /// Customisation options for the [QuickReplyMessage].
  final QuickReplyMessageOptions options;

  /// Show user name for the received message. Useful for a group chat.
  final bool showName;

  /// Enables link (URL) preview.
  final bool usePreviewData;

  /// User agent to fetch preview data with.
  final String? userAgent;

  @override
  Widget build(BuildContext context) {
    final enlargeEmojis =
        emojiEnlargementBehavior != EmojiEnlargementBehavior.never;
    final theme = InheritedChatTheme.of(context).theme;
    final user = InheritedUser.of(context).user;
    final width = MediaQuery.of(context).size.width;
    if (usePreviewData &&
        onPreviewDataFetched != null &&
        message.text != null) {
      final urlRegexp = RegExp(regexLink, caseSensitive: false);
      final matches = urlRegexp.allMatches(message.text!);
      if (matches.isNotEmpty) {
        return _linkPreview(user, width, context);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: theme.messageInsetsHorizontal,
        vertical: theme.messageInsetsVertical,
      ),
      child: _quickReplyWidgetBuilder(user, context, false),
    );
  }

  Widget _linkPreview(
    types.User user,
    double width,
    BuildContext context,
  ) {
    final linkDescriptionTextStyle = message.isAuthor ?? false
        ? InheritedChatTheme.of(context)
            .theme
            .sentMessageLinkDescriptionTextStyle
        : InheritedChatTheme.of(context)
            .theme
            .receivedMessageLinkDescriptionTextStyle;
    final linkTitleTextStyle = message.isAuthor ?? false
        ? InheritedChatTheme.of(context).theme.sentMessageLinkTitleTextStyle
        : InheritedChatTheme.of(context)
            .theme
            .receivedMessageLinkTitleTextStyle;
    return LinkPreview(
      enableAnimation: true,
      metadataTextStyle: linkDescriptionTextStyle,
      metadataTitleStyle: linkTitleTextStyle,
      onLinkPressed: options.onLinkPressed,
      onPreviewDataFetched: _onPreviewDataFetched,
      openOnPreviewImageTap: options.openOnPreviewImageTap,
      openOnPreviewTitleTap: options.openOnPreviewTitleTap,
      padding: EdgeInsets.symmetric(
        horizontal:
            InheritedChatTheme.of(context).theme.messageInsetsHorizontal,
        vertical: InheritedChatTheme.of(context).theme.messageInsetsVertical,
      ),
      previewData: message.previewData,
      text: message.text!,
      textWidget: _quickReplyWidgetBuilder(user, context, false),
      userAgent: userAgent,
      width: width,
    );
  }

  void _onPreviewDataFetched(types.PreviewData previewData) {
    if (message.previewData == null) {
      onPreviewDataFetched?.call(message, previewData);
    }
  }

  Widget _quickReplyWidgetBuilder(
    types.User user,
    BuildContext context,
    bool enlargeEmojis,
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
    final emojiTextStyle = message.isAuthor ?? false
        ? theme.sentEmojiMessageTextStyle
        : theme.receivedEmojiMessageTextStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // if (showName)
        // nameBuilder?.call(message.author.id) ??
        // UserName(author: message.author),
        if (enlargeEmojis)
          if (options.isTextSelectable)
            SelectableText('selectable text o day', style: emojiTextStyle)
          else
            Text('text o day', style: emojiTextStyle)
        else
          QuickReplyMessageText(
            bodyLinkTextStyle: bodyLinkTextStyle,
            bodyTextStyle: bodyTextStyle,
            boldTextStyle: boldTextStyle,
            codeTextStyle: codeTextStyle,
            options: options,
            text: message.content?.text ?? '',
            content: message.content,
          ),
      ],
    );
  }
}

/// Widget to reuse the markdown capabilities, e.g., for previews.
class QuickReplyMessageText extends StatelessWidget {
  const QuickReplyMessageText({
    super.key,
    this.bodyLinkTextStyle,
    required this.bodyTextStyle,
    this.boldTextStyle,
    this.codeTextStyle,
    this.maxLines,
    this.options = const QuickReplyMessageOptions(),
    this.overflow = TextOverflow.clip,
    required this.text,
    this.content,
  });

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

  /// See [QuickReplyMessage.options].
  final QuickReplyMessageOptions options;

  /// See [ParsedText.overflow].
  final TextOverflow overflow;

  /// Text that is shown as markdown.
  final String text;

  final Content? content;

  @override
  Widget build(BuildContext context) => _buildWidgetQuickReply(context);

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
        text: text,
        textWidthBasis: TextWidthBasis.longestLine,
      );

  Widget _buildWidgetQuickReply(BuildContext context) => Column(
        children: [
          _buildParsedTextWidget(context),
          const SizedBox(height: 10),
          content?.buttons != null
              ? Column(
                  children: [..._buildListButton(content!)],
                )
              : Container()
        ],
      );
  List<Widget> _buildListButton(Content content) {
    final listButton = <Widget>[];
    final numberButton = content.buttons!.length;
    for (var i = 0; i < numberButton; i++) {
      listButton.add(const Divider(
        height: 0,
      ));
      listButton.add(buildSingleButton(i));
    }
    return listButton;
  }

  Widget buildSingleButton(int index) => TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue,
          padding: EdgeInsets.zero,
          //  backgroundColor: Colors.white // foreground
        ),
        onPressed: () {},
        child: Text(content?.buttons?[index].title ?? ''),
      );
}

@immutable
class QuickReplyMessageOptions {
  const QuickReplyMessageOptions({
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
