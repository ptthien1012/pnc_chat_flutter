import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:pnc_chat_flutter/src/flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:pnc_chat_flutter/pnc_chat_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('contains file message', (WidgetTester tester) async {
    // Build the Chat widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Chat(
            messages:  [
              types.FileMessage(
                isAuthor: true,
                // author: types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
                id: 'id',
                name: 'file',
                size: 100,
                uri: 'file',
              ),
            ],
            onSendPressed: (types.PartialText message) => {},
            onPayload: (contendButton) => {},
            user: const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c'),
          ),
        ),
      ),
    );

    // Trigger a frame.
    await tester.pump();

    // Expect to find one FileMessage.
    expect(find.byType(FileMessage), findsOneWidget);
  });
}
