import 'package:disposebag/disposebag.dart';
import 'package:flutter/foundation.dart';
import '/extension/dynamic_extension.dart';
import 'package:rxdart/subjects.dart';

class UIDelegate<S, A> {
  final disposableBag = DisposeBag();

  final uiStatesSubject = BehaviorSubject<S>();
  final uiActionsSubject = BehaviorSubject<A>();

  Stream<S> uiStates() {
    return uiStatesSubject;
  }

  Stream<A> uiActions() {
    return uiActionsSubject;
  }

  add(S uiState) {
    debugPrint(uiState.runtimeType.toString());
    uiStatesSubject.add(uiState);
  }

  addAction(A uiAction) {
    debugPrint(uiAction.runtimeType.toString());
    uiActionsSubject.add(uiAction);
  }

  dispose() {
    if (!disposableBag.isDisposed) {
      disposableBag.dispose();
    }
  }

  R cache<T, R>(T input, R Function(T) processor) {
    return cachableTransform<R>((_) {
      return processor(input);
    });
  }
}
