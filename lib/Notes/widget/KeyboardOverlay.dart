// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class InputDoneView extends StatelessWidget {
  final bool ispop;
  const InputDoneView({Key? key, this.ispop = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: CupertinoColors.darkBackgroundGray,
        child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: CupertinoButton(
                padding: const EdgeInsets.only(right: 24.0, top: 0.0, bottom: 0.0),
                onPressed: () {
                  if (ispop) {
                    Navigator.pop(context);
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: const Text("Done",
                    style: TextStyle(
                      color: CupertinoColors.activeBlue,
                    )),
              ),
            )));
  }
}

class KeyboardOverlay {
  static OverlayEntry? _overlayEntry;

  static showOverlay(BuildContext context) {
    if (_overlayEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom, right: 0.0, left: 0.0, child: const InputDoneView());
    });

    overlayState.insert(_overlayEntry!);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
