class UserRepository {
  Future<String> fetchUserName() async {
    await Future.delayed(Duration(seconds: 1));
    return 'Alice';
  }
}