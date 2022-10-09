import 'package:flutter/material.dart';

import '/extension/widget_extensions.dart';

class UIUtils {
  static Widget getLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static void showErrorDialog(BuildContext context, String title,
      String message, String actionButtonText) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(actionButtonText),
              ),
            ],
          );
        });
  }

  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static Future showBottomSheet({
    required BuildContext context,
    required List<String> items,
    required Function(int) onSelect,
  }) {
    return showModalBottomSheet(
      isScrollControlled: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            items.length,
            (index) => ListTile(
              title: Text(
                items[index],
              ),
              onTap: () {
                Navigator.of(context).pop();
                onSelect(index);
              },
            ),
          ),
        ),
      ),
    );
  }

  static Future showWidgetInDialog({
    required BuildContext context,
    required String title,
    required Widget widget,
    required bool isCancelable,
    required bool hasClosebutton,
  }) {
    return showDialog(
        context: context,
        barrierDismissible: isCancelable,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title),
                      CloseButton(
                          color: const Color(0xFFD5D3D3),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }).changeVisibility(isVisible: hasClosebutton),
                    ]),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget,
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
