import 'package:dio/dio.dart';
import 'package:e_rose/models/accident_type_model.dart';
import 'package:e_rose/models/address.dart';
import 'package:e_rose/models/repositories/accident_type_repository.dart';
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
    required List<AccidentTypeModel> accidentTypes,
    required List<AccidentTypeModel> selectedAccidentType,
    required SelectedAccidentsErrorType accidentsErrorType,
    required String? allReadyTakenErrorMessage,
    LatLng? selectedPos,
    Address? address,
  }) = _RegisterState;
}

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<RegisterState> build() async {
    final accidentTypes =
        await ref.read(accidentTypeRepositoryProvider).getAccidentTypes();
    return RegisterState(
      selectedAccidentType: [],
      accidentTypes: accidentTypes,
      accidentsErrorType: SelectedAccidentsErrorType.notEnought,
      allReadyTakenErrorMessage: null,
    );
  }

  void selectAccident(AccidentTypeModel accidentType) {
    if (state.value!.selectedAccidentType.length < 3) {
      final selectedAccidentTypes = [...state.value!.selectedAccidentType];
      final accidentTypes = [...state.value!.accidentTypes];
      accidentTypes.remove(accidentType);
      selectedAccidentTypes.add(accidentType);
      state = AsyncData(
        state.value!.copyWith(
          selectedAccidentType: selectedAccidentTypes,
          accidentTypes: accidentTypes,
          accidentsErrorType: SelectedAccidentsErrorType.none,
        ),
      );
    } else {
      state = AsyncData(state.value!
          .copyWith(accidentsErrorType: SelectedAccidentsErrorType.tooMany));
    }
  }

  void unSelectAccident(AccidentTypeModel accident) {
    if (state.value!.selectedAccidentType.isNotEmpty) {
      final selectedAccidentTypes = [...state.value!.selectedAccidentType];
      final accidentTypes = [...state.value!.accidentTypes];
      accidentTypes.add(accident);
      selectedAccidentTypes.remove(accident);
      accidentTypes.sort((a, b) => a.id.compareTo(b.id));
      SelectedAccidentsErrorType errorType = selectedAccidentTypes.isEmpty
          ? SelectedAccidentsErrorType.notEnought
          : SelectedAccidentsErrorType.none;
      state = AsyncData(
        state.value!.copyWith(
          selectedAccidentType: selectedAccidentTypes,
          accidentTypes: accidentTypes,
          accidentsErrorType: errorType,
        ),
      );
    }
  }

  Future<void> selectMapPoint(LatLng pos) async {
    final address = await GeoLocatorService.getAddressFromPos(pos);
    state = AsyncData(
      state.value!.copyWith(
        selectedPos: pos,
        address: address,
      ),
    );
  }

  Future<LatLng?> selectPointFromAddress(String addressString) async {
    final pos = await GeoLocatorService.getPosFromAddress(addressString);
    Address? address;
    if (pos != null) {
      address = await GeoLocatorService.getAddressFromPos(pos);
    }
    state =
        AsyncData(state.value!.copyWith(selectedPos: pos, address: address));
    return pos;
  }

  Future<bool> register(RegisterModel model) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final authRepo = ref.read(authRepositoryProvider);
      final response = await authRepo.register(model);
      await prefs.setString("token", response.token);
      return true;
    } on DioError catch (ex) {
      if (ex.response?.data != null) {
        state = AsyncData(
          state.value!.copyWith(
            allReadyTakenErrorMessage: ex.response!.data.toString(),
          ),
        );
      }
      return false;
    }
  }
}
