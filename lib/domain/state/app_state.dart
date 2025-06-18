// app_state.dart
import 'package:flutter/foundation.dart';
import 'package:snackautomat_2502/models/snack.dart';

@immutable
class AppState {
  final List<Snack> availableSnacks;
  final int currentCredit; // Ändere von double zu int (Guthaben in Cents)
  final String? selectedSnackId;

  const AppState({
    this.availableSnacks = const [],
    this.currentCredit = 0, // Initialisiere mit 0 Cents
    this.selectedSnackId,
  });

  AppState copyWith({
    List<Snack>? availableSnacks,
    int? currentCredit, // Ändere hier auch zu int
    String? selectedSnackId,
  }) {
    return AppState(
      availableSnacks: availableSnacks ?? this.availableSnacks,
      currentCredit: currentCredit ?? this.currentCredit,
      selectedSnackId: selectedSnackId ?? this.selectedSnackId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          listEquals(
            availableSnacks,
            other.availableSnacks,
          ) &&
          currentCredit == other.currentCredit &&
          selectedSnackId == other.selectedSnackId;

  @override
  int get hashCode =>
      availableSnacks.hashCode ^
      currentCredit.hashCode ^
      selectedSnackId.hashCode;

  @override
  String toString() {
    return 'AppState{availableSnacks: $availableSnacks, currentCredit: $currentCredit, selectedSnackId: $selectedSnackId}';
  }
}
