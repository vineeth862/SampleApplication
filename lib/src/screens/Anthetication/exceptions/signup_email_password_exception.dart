class SignupEmailPasswordFailure {
  const SignupEmailPasswordFailure(
      [this.message = "An Unknown Error Occured."]);
  final String message;

  factory SignupEmailPasswordFailure.code(String code) {
    switch (code) {
      case "weak-password":
        return SignupEmailPasswordFailure("Please enter a stronger password");
      case "invalid-email":
        return SignupEmailPasswordFailure("Email is not valid");
      case "email-already-in-use":
        return SignupEmailPasswordFailure(
            "An account already exist for this email");
      case "operation-not-allowed":
        return SignupEmailPasswordFailure("Operation is not allowed");
      case "user-disabled":
        return SignupEmailPasswordFailure("This user has been disabled");
      default:
        return SignupEmailPasswordFailure();
    }
  }
}
