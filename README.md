<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Architectural solution for Flutter apps
Inspired from Bloc pattern

## Features

More flexibility than Bloc pattern
Simple to use
Easy to test
Easy to maintain

## Getting started

in order to use this package fully you need to install the following packages:

[sealed_class_annotations](https://pub.dev/packages/sealed_class_annotations)
[sealed_class_generator](https://pub.dev/packages/sealed_class_generator)

## Usage

create your model class like following:

```dart
import 'package:sealed_class_annotations/sealed_class_annotations.dart';

part 'signin_ui_state.sealed.dart';

@Sealed()
abstract class _SignInUIState {
  void showContent(
    bool isSignIn,
    bool isLoading,
    String? errorMessage,
  );
}

@Sealed()
abstract class _SignInUIAction {
  void showResetPasswordDialog();
}
```

then create your delegate class like following:

```dart
class SignInUiDelegate extends UIDelegate<SignInUIState, SignInUIAction> {
  bool _isSignIn = true;
  bool _isLoading = false;

  SignInUiDelegate(this.authenticationApiHandler);

  void init() {
    _updateTheUi();
  }

  void tabSwitched(int index) {
    _isSignIn = index == 0;

    _updateTheUi();
  }

  void _updateTheUi({String? errorMessage}) {
    add(
      SignInUIState.showContent(
        isSignIn: _isSignIn,
        isLoading: _isLoading,
        errorMessage: errorMessage,
      ),
    );
  }

  void resetPasswordPressed() {
    addAction(const SignInUIAction.showResetPasswordDialog());
  }

  Future<String> resetPassword(String email) {
    return authenticationApiHandler.resetEmail(email);
  }

  void signInSignupButtonPressed({
    required String email,
    required String password,
  }) {
    _isLoading = true;
    _updateTheUi();

    if (_isSignIn) {
      authenticationApiHandler
          .signinViaEmail(
        email: email,
        password: password,
      )
          .then((value) {
        _isLoading = false;

        AppNavigation.openHome();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        _isLoading = false;
        _updateTheUi(errorMessage: "login failed!");
      });
    } else {
      authenticationApiHandler
          .signupViaEmail(
        email: email,
        password: password,
      )
          .then((value) {
        _isLoading = false;

        AppNavigation.openHome();
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        _isLoading = false;
        _updateTheUi(errorMessage: "signup failed!");
      });
    }
  }
}
```

And in your UI class you can use it like following:

```dart
@override
  void initState() {
    super.initState();
    widget.delegate.init();

    widget.delegate.uiActions().listen((event) {
      event.when(
        showResetPasswordDialog: () => // show reset password dialog widget,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.delegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.delegate.getBuilder(
        builder: (uiState) => uiState.when(
            showContent: (isSignIn, isLoading, errorMessage) =>
                _buildContent(
            isSignIn,
            isLoading,
            errorMessage,
            ).padding(horizontal: 16, vertical: 16),
        ),
        )
  }
```
