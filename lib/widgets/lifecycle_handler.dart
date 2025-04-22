import 'package:flutter/material.dart';

/// Add inside the widget where you want to monitor the status of the application.
/// At the moment, it is only possible to track [AppLicecycleState.resumed].
class _LifecycleHandler extends StatefulWidget {
  const _LifecycleHandler({Key? key, this.onClose}) : super(key: key);

  final Function()? onClose;

  @override
  _LifecycleHandlerState createState() => _LifecycleHandlerState();
}

class _LifecycleHandlerState extends State<_LifecycleHandler>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // The application has returned to the active state.
      if (widget.onClose != null) {
        widget.onClose!();
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
