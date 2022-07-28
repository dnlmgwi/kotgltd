import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { isNotDetermined, isOn, isOff }

class NetworkDetectorNotifier extends ChangeNotifier {
  NetworkStatus _networkState = NetworkStatus.isOn;

  void isOn() {
    _networkState = NetworkStatus.isOn;
    notifyListeners();
  }

  void isNotDetermined() {
    _networkState = NetworkStatus.isNotDetermined;
    notifyListeners();
  }

  NetworkStatus currentState() {
    return _networkState;
  }

  void isOff() {
    _networkState = NetworkStatus.isOff;
    notifyListeners();
  }

  Stream<Enum?> networkStateChanges() => Stream<Enum?>.value(_networkState);

  connectionState() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t

      switch (result) {
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          _networkState = NetworkStatus.isOn;
          notifyListeners();
          break;
        case ConnectivityResult.none:
          _networkState = NetworkStatus.isOff;
          notifyListeners();
          break;
        default:
          break;
      }
    });
  }
}
