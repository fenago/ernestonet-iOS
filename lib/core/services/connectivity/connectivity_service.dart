import 'dart:async';

import 'package:connectivity/connectivity.dart';

import '../../../ui/widgets/internet_connection_error.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController = StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      default:
        return ConnectivityStatus.offline;
    }
  }
}
