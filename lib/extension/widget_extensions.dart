import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '/utils/ui_utils.dart';

extension StyledWidget on Widget {
  Widget padding({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          top: top ?? vertical ?? all ?? 0.0,
          bottom: bottom ?? vertical ?? all ?? 0.0,
          left: left ?? horizontal ?? all ?? 0.0,
          right: right ?? horizontal ?? all ?? 0.0,
        ),
        child: this,
      );

  Widget margin({
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Container(
        margin: EdgeInsets.only(
          top: top ?? vertical ?? all ?? 0.0,
          bottom: bottom ?? vertical ?? all ?? 0.0,
          left: left ?? horizontal ?? all ?? 0.0,
          right: right ?? horizontal ?? all ?? 0.0,
        ),
        child: this,
      );

  Widget container({
    double? height,
    double? width,
  }) =>
      SizedBox(
        height: height ?? null,
        width: width ?? null,
        child: this,
      );

  Widget expanded({int flex = 1}) => Expanded(
        flex: flex,
        child: this,
      );

  Widget centered() => Center(
        child: this,
      );

  Widget fit({
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      FittedBox(
        fit: BoxFit.scaleDown,
        alignment: alignment,
        child: this,
      );

  Widget sized({
    double? height,
    double? width,
  }) =>
      SizedBox(
        width: width,
        height: height,
        child: this,
      );

  Widget colored({required Color color}) => Container(
        color: color,
        child: this,
      );

  Widget makeCircular() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: this,
    );
  }

  Widget badged({String text = ""}) {
    return Stack(
      children: [
        this,
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: const BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  Widget showLoading({required bool isVisible}) {
    if (isVisible) {
      return UIUtils.getLoadingWidget();
    } else {
      return this;
    }
  }

  Widget changeVisibility({required bool isVisible}) {
    if (isVisible) {
      return this;
    } else {
      return Container();
    }
  }

  Widget fractionallySizedBox({
    final double? widthFactor,
    final double? heightFactor,
  }) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: this,
    );
  }

  Widget onScrollListener(Function(ScrollDirection) onScrollDirectionChanged) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        final ScrollDirection direction = notification.direction;
        onScrollDirectionChanged(direction);
        return true;
      },
      child: this,
    );
  }

  Widget addSlideAnimation({
    required bool show,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedSlide(
      duration: duration,
      offset: show ? Offset.zero : const Offset(0, 2),
      child: AnimatedOpacity(
        duration: duration,
        opacity: show ? 1 : 0,
        child: this,
      ),
    );
  }

  Future showInDialog({
    required BuildContext context,
    required String title,
    bool isCancelable = true,
    bool hasClosebutton = false,
  }) {
    return UIUtils.showWidgetInDialog(
      context: context,
      title: title,
      widget: this,
      isCancelable: isCancelable,
      hasClosebutton: hasClosebutton,
    );
  }
}
