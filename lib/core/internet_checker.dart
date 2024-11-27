import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class InternetChecker {
  Future<bool> get isConnected;
}

class InternetCheckerImpl implements InternetChecker {
  final InternetConnectionChecker internetConnectionChecker;

  InternetCheckerImpl({required this.internetConnectionChecker});
  @override
  Future<bool> get isConnected async => await internetConnectionChecker.hasConnection;
}
