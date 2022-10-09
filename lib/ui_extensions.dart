import 'package:flutter/material.dart';
import '/ui_delegate.dart';
import '/utils/ui_utils.dart';

extension UIExtensions on Widget {}

extension UIDelegateExtensions<S, A> on UIDelegate<S, A> {
  StreamBuilder<S> getBuilder({required Widget Function(S) builder}) {
    return StreamBuilder(
        stream: uiStates().distinct(),
        builder: (BuildContext context, AsyncSnapshot<S> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data as S);
          } else {
            return UIUtils.getLoadingWidget();
          }
        });
  }
}
