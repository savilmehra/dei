import 'package:clean_framework/clean_framework.dart';

enum ServiceStatus { failed, success, unknown }

class SignInViewModel extends ViewModel {
  final String token;
  final String? userName;
  final String? password;
  final ServiceStatus serviceStatus;
  late final bool isLoading;
  final String errorMessage;
  SignInViewModel({

    required this.token,
    this.isLoading=false,
    this.userName,
    this.password,
    this.errorMessage="",
    this.serviceStatus = ServiceStatus.unknown,
  });

  @override
  List<Object> get props => [token, serviceStatus,isLoading,errorMessage];
}
