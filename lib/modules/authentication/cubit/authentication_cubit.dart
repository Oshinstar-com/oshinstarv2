import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oshinstar/modules/authentication/api/authentication.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  // Validates if user is authenticated
  Future<void> isAuthenticated() async {}

  // Validates if provided e-mail exists in database
  Future<void> checkEmail(String email) async {}

  // Receives any parameter from user model and sends to backend for update
  Future<void> updateUser(Map<String, dynamic> updates) async {
    final response = await AuthenticationApi.updateUser(updates);

    print(response);
  }
}
