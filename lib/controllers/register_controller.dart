import 'package:e_rose/models/accident.dart';
import 'package:e_rose/models/repositories/accident_repository.dart';
import 'package:e_rose/models/repositories/auth_repository.dart';
import 'package:e_rose/services/api/dto/auth/register_model.dart';
import 'package:e_rose/services/geolocator_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_controller.g.dart';
part 'register_controller.freezed.dart';

enum SelectedAccidentsErrorType { tooMany, notEnought, none }

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    required List<Accident> accidents,
    required List<Accident> selectedAccident,
    required SelectedAccidentsErrorType accidentsErrorType,
    LatLng? selectedPos,
  }) = _RegisterState;
}

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<RegisterState> build() async {
    final accidents = await ref.read(accidentRepositoryProvider).getAccidents();
    return RegisterState(
      selectedAccident: [],
      accidents: accidents,
      accidentsErrorType: SelectedAccidentsErrorType.notEnought,
    );
  }

  void selectAccident(Accident accident) {
    if (state.value!.selectedAccident.length < 3) {
      final selectedAccidents = [...state.value!.selectedAccident];
      final accidents = [...state.value!.accidents];
      accidents.remove(accident);
      selectedAccidents.add(accident);
      state = AsyncData(
        state.value!.copyWith(
          selectedAccident: selectedAccidents,
          accidents: accidents,
          accidentsErrorType: SelectedAccidentsErrorType.none,
        ),
      );
    } else {
      state = AsyncData(state.value!
          .copyWith(accidentsErrorType: SelectedAccidentsErrorType.tooMany));
    }
  }

  void unSelectAccident(Accident accident) {
    if (state.value!.selectedAccident.isNotEmpty) {
      final selectedAccidents = [...state.value!.selectedAccident];
      final accidents = [...state.value!.accidents];
      accidents.add(accident);
      selectedAccidents.remove(accident);
      accidents.sort((a, b) => a.id.compareTo(b.id));
      SelectedAccidentsErrorType errorType = selectedAccidents.isEmpty
          ? SelectedAccidentsErrorType.notEnought
          : SelectedAccidentsErrorType.none;
      state = AsyncData(
        state.value!.copyWith(
          selectedAccident: selectedAccidents,
          accidents: accidents,
          accidentsErrorType: errorType,
        ),
      );
    }
  }

  void selectMapPoint(LatLng pos) {
    state = AsyncData(state.value!.copyWith(selectedPos: pos));
  }

  Future<String> getAddressFromCoords() async {
    if (state.value?.selectedPos != null) {
      await GeoLocatorService.getAddressFromPos(ref, state.value!.selectedPos!);
    }
    return "";
  }

  Future<bool> register(RegisterModel model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final authRepo = ref.read(authRepositoryProvider);
      final response = await authRepo.register(model);
      await prefs.setString("token", response.token);
      return true;
    } catch (ex) {
      return false;
    }
  }
}
