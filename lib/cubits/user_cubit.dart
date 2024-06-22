part of 'cubits.dart';

class UserCubit extends HydratedCubit<Map<String, dynamic>> {
  UserCubit() : super({});

  void setUserInfo(Map<String, dynamic> userInfo) {
    final currentState = state as Map<String, dynamic>;
    final updatedState = Map<String, dynamic>.from(currentState);

    userInfo.forEach((key, value) {
      updatedState[key] = value;
    });

    emit(updatedState);
  }

  Future<void> logout(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LandingScreen()));

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
