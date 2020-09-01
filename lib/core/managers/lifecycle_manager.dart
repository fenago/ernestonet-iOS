import 'package:edustar/core/services/stoppable_service.dart';
import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget child;

  const LifeCycleManager({Key key, this.child}) : super(key: key);

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {

  List<StoppableService> services = [
    // locator<UploadService>(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() { 
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    services.forEach((service) {
      if (state == AppLifecycleState.resumed) {
        service.start();
      } else {
        service.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

class LocationService {
}