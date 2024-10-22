abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String error;
  SignUpError({required this.error});
}

class CretaeUserSuccess extends SignUpState {}

class CretaeUserFaluire extends SignUpState {
  final String error;
  CretaeUserFaluire({required this.error});
}
