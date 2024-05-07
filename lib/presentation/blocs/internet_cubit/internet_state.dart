part of 'internet_cubit.dart';

enum ConnectivityStatus { connected, disconnected }

final class InternetStatus {
  final ConnectivityStatus status;

  const InternetStatus(this.status);
}
