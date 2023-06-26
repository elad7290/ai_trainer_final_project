import 'package:ai_trainer/views/pages/login_page.dart';
import 'package:ai_trainer/views/widgets/sign_in_button_widget.dart';
import 'package:ai_trainer/views/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Login widget exists ", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: LoginPage(onClickedSignUp: () {}),
        ),
      ),
    );

    var textField = find.byType(TextFieldWidget);
    expect(textField, findsWidgets);
    await tester.enterText(textField.first, "elad");
    expect(find.text("elad"), findsOneWidget);
    var button = find.byType(SignInButtonWidget);
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pump();
    expect(find.text("Enter a valid email"), findsOneWidget);
  });
}
