part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;
  // Hàm khởi tạo để truyền email và password vào trong event
  const SignInRequired(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutProcess extends SignInEvent {
  @override
  List<Object> get props => [];
}
class SignOutRequired extends SignInEvent {}