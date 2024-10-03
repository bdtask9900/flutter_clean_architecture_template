import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart' as connectivity;

class ConnectivityService {
  final connectivity.Connectivity _connectivity = connectivity.Connectivity();

  // Method to check current connection status
  static Future<bool> checkInternetConnection() async {
    final connectivityResult =
        await connectivity.Connectivity().checkConnectivity();
    if (Platform.isAndroid) {
      if (connectivityResult.contains(connectivity.ConnectivityResult.mobile)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.wifi)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.ethernet)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.vpn)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.bluetooth)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.other)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.none)) {
        return false;
      } else {
        return false;
      }
    } else {
      if (connectivityResult.contains(connectivity.ConnectivityResult.mobile)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.wifi)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.ethernet)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.vpn)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.bluetooth)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.other)) {
        return true;
      } else if (connectivityResult
          .contains(connectivity.ConnectivityResult.none)) {
        return false;
      } else {
        return false;
      }
    }
  }

  // Stream to listen to connectivity changes
  Stream<List<connectivity.ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;
}
