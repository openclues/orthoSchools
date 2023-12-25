import 'package:flutter/material.dart';

class SnackBarWidget {
  static SnackBar success(String message) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
  }

  static buildSnacBarFail(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        animation: const AlwaysStoppedAnimation(1),
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        // actionOverflowThreshold: 0,
        clipBehavior: Clip.antiAlias,
        hitTestBehavior: HitTestBehavior.opaque,
        elevation: 20,
        showCloseIcon: true,

        closeIconColor: Colors.white,
        action: SnackBarAction(
          label: 'close',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        backgroundColor: Colors.red,
        content: Align(
          alignment: Alignment.topCenter,
          child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.red,
              ),
              child: Text(
                message,
                textAlign: TextAlign.start,
              )),
        ),
      ),
    );
  }
}
