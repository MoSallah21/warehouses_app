class AppFailure{
  final String message;

  @override
  String toString() {
    return 'AppFailure{message: $message}';
  }

  AppFailure([this.message='Sorry, an unexpected error occurred!']);
}