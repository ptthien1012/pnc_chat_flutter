import 'package:flutter/material.dart';

import '../state/inherited_chat_theme.dart';
import '../state/inherited_l10n.dart';

/// A class that represents attachment button widget.
class MenuButton extends StatelessWidget {
  /// Creates attachment button widget.
  const MenuButton({
    super.key,
    this.isPressed = false,
    this.onPressed,
    this.padding = EdgeInsets.zero,
  });

  /// Show a loading indicator instead of the button.
  final bool isPressed;

  /// Callback for attachment button tap event.
  final VoidCallback? onPressed;

  /// Padding around the button.
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsetsDirectional.fromSTEB(
          8,
          0,
          0,
          0,
        ),
        child: IconButton(
          constraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 24,
          ),
          // icon: isPressed
              // ? SizedBox(
                  // height: 20,
                  // width: 20,
                  // child: CircularProgressIndicator(
                    // backgroundColor: Colors.transparent,
                    // strokeWidth: 1.5,
                    // valueColor: AlwaysStoppedAnimation<Color>(
                      // InheritedChatTheme.of(context).theme.inputTextColor,
                    // ),
                  // ),
                // )
              // :
              // Image.asset(
              // 'assets/icon-document.png',
              // color: InheritedChatTheme.of(context).theme.inputTextColor,
              // package: 'pnc_chat_flutter',
              // ),
              icon: Icon(
                  Icons.menu,
                  color: isPressed ? InheritedChatTheme.of(context).theme.primaryColor : InheritedChatTheme.of(context).theme.inputTextColor,
                ),

          onPressed: onPressed,
          padding: padding,
          splashRadius: 24,
          // tooltip:
          // InheritedL10n.of(context).l10n.MenuButtonAccessibilityLabel,
        ),
      );
}
