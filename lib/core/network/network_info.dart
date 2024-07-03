import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl() {
    _connectivity.onConnectivityChanged.listen((result) {
      final isConnected = result != ConnectivityResult.none;
      _connectionChangedController.add(isConnected);
    });
  }

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionChangedController = StreamController<bool>.broadcast();

  @override
  Stream<bool> get onConnectionChanged => _connectionChangedController.stream;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void dispose() {
    _connectionChangedController.close();
  }
}
