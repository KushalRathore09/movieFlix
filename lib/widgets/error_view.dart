import 'package:flutter/material.dart';

import '../colors.dart';
import 'custom_button.dart';

typedef OnTryAgainPressed = void Function();

class ErrorView extends StatelessWidget {
  /// Icon representing the error.
  final Icon icon;

  /// Content/error message to display.
  final String content;

  /// Callback when try again button is pressed.
  final OnTryAgainPressed onPressed;

  /// Controls try again button's visibility. Defaults to true.
  final bool retryVisible;

  /// Action button text. Defaults to "Try again".
  final String actionText;

  ErrorView({
    this.icon,
    this.content,
    this.onPressed,
    this.retryVisible = true,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        icon ??
            Icon(
              Icons.error_outline,
              color: colorBlackGradient70,
              size: 40,
            ),
        Container(
          margin: const EdgeInsets.all(12),
          child: Text(
            content ??
                'Something went wrong, Please try again',
            textAlign: TextAlign.center,
            style: TextStyle(color: colorBlackGradient70)
          ),
        ),
        Visibility(
          child: CustomButton(
            child: Text(actionText ??
                'Try again'),
            onPressed: onPressed,
          ),
          visible: retryVisible,
        )
      ],
    );
  }
}
