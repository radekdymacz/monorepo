import 'package:flutter/material.dart';
import 'package:metrics/auth/presentation/state/auth_notifier.dart';
import 'package:metrics/auth/presentation/widgets/strategy/sign_in_option_strategy.dart';
import 'package:metrics/base/presentation/widgets/hand_cursor.dart';
import 'package:metrics/common/presentation/metrics_theme/widgets/metrics_theme.dart';
import 'package:provider/provider.dart';

/// A widget that displays a button for a sign in option.
class SignInOptionButton extends StatelessWidget {
  /// A strategy for a sign in option this button stands for.
  final SignInOptionStrategy strategy;

  /// Creates a new instance of the login option button
  /// with the given [strategy].
  ///
  /// The [strategy] must not be null.
  const SignInOptionButton({
    Key key,
    @required this.strategy,
  })  : assert(strategy != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginTheme = MetricsTheme.of(context).loginTheme;
    final loginOptionStyle = loginTheme.loginOptionButtonStyle;

    return HandCursor(
      child: RaisedButton(
        color: loginOptionStyle.color,
        hoverColor: loginOptionStyle.hoverColor,
        elevation: loginOptionStyle.elevation,
        hoverElevation: loginOptionStyle.elevation,
        focusElevation: loginOptionStyle.elevation,
        highlightElevation: loginOptionStyle.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        onPressed: () => _signIn(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.network(
                strategy.asset,
                height: 18.0,
                width: 18.0,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              strategy.label,
              style: loginOptionStyle.labelStyle,
            ),
          ],
        ),
      ),
    );
  }

  /// Starts the sign in process.
  void _signIn(BuildContext context) {
    final notifier = Provider.of<AuthNotifier>(context, listen: false);
    strategy.signIn(notifier);
  }
}
