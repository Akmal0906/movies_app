import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetStatus> {
  InternetCubit()
      : super(const InternetStatus(ConnectivityStatus.disconnected));

  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    _updateConnectivityResult(connectivityResult.first);
  }

  _updateConnectivityResult(ConnectivityResult result) async {
    print(result.toString());
    if (result == ConnectivityResult.none) {
      emit(const InternetStatus(ConnectivityStatus.disconnected));
    } else {
      emit(const InternetStatus(ConnectivityStatus.connected));
    }
  }

  late StreamSubscription<ConnectivityResult> _subscription;

  void trackConnectivityChange(){
    Connectivity().onConnectivityChanged.listen((result) {
      _updateConnectivityResult(result.first);
    });
  }

  void dispose(){
    _subscription.cancel();
  }
}
