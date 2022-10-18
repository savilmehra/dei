import 'package:clean_framework/clean_framework.dart';

class SignInEntity extends Entity {
  final String token;
  final String userName;
  final String passWord;

  SignInEntity({
    List<EntityFailure> errors = const [],
    this.token = '',
    this.userName = '',
    this.passWord = '',
  }) : super(errors: errors);

  @override
  List<Object> get props => [errors, token, userName, passWord];

  @override
  SignInEntity merge({
    List<EntityFailure>? errors,
    String? token,
    String? userName,
    String? passWord,
  }) {

    return SignInEntity(
      errors: errors ?? this.errors,
      token: token ?? this.token,
      userName: userName ?? this.userName,
      passWord: passWord ?? this.passWord,
    );
  }
}
