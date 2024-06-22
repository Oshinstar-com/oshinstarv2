part of 'cubits.dart';

class MetaCubit extends HydratedCubit<Map<String, dynamic>> {
  MetaCubit() : super({});

  void setMetadata(Map<String, dynamic> data) {
    // emit(_copyWith(state, data));
  }

  void _copyWith(Map<String, dynamic> original, Map<String, dynamic> updates) {
    final newState = Map<String, dynamic>.from(original);
    // emit dis shet = {...newState, ...updates};
    // return newState;
  }

  @override
  Map<String, dynamic>? fromJson(Map<String, dynamic> json) {
    try {
      return json;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(Map<String, dynamic> state) {
    try {
      return state;
    } catch (e) {
      return null;
    }
  }
}
