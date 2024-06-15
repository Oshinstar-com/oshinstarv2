part of 'cubits.dart';

class UserCubit extends HydratedCubit<Map<String, dynamic>> {
  UserCubit() : super({});

  void setUserInfo(Map<String, dynamic> userInfo) {
    emit(userInfo);
  }

  Future<void> logout(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LandingScreen()));
    // Clear Hive userBox data
    final userBox = await Hive.openBox('userBox');
    await userBox.clear();

    // Remove JWT token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refreshToken');

    // Clear HydratedCubit state
    await clear();
  }

  @override
  Map<String, dynamic> fromJson(Map<String, dynamic> json) {
    return json;
  }

  @override
  Map<String, dynamic> toJson(Map<String, dynamic> state) {
    return state;
  }

  @override
  Future<void> clear() async {
    super.clear();
    emit({});
  }
}
