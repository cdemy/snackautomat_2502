import 'package:flutter/foundation.dart';
import 'package:snackautomat_2502/models/coinstack.dart';
import 'package:snackautomat_2502/models/snack.dart';

@immutable
/// Class AppState that keeps the state of the whole app as an object
class AppState {
  /// List of available Snacks
  final List<Snack> availableSnacks;

  /// Coins those user has added
  final CoinStack input;

  /// Coins those we have inside the snackautomate
  final CoinStack machine;

  /// Coins that we have to return to the user
  final CoinStack output;

  /// Message that user sees at the screen of snackautomate
  final String? displayMessage;

  /// Represents the snack selected by user
  final Snack? selectedSnack;

  /// Regular constructor
  const AppState({
    this.availableSnacks = const [],
    this.input = const CoinStack(),
    this.machine = const CoinStack(),
    this.output = const CoinStack(),
    this.displayMessage,
    this.selectedSnack,
  });

  /// Returns new App State object from old App State object with some attribute changes
  AppState copyWith({
    List<Snack> Function()? availableSnacks,
    List<Snack> Function()? cartItems,
    CoinStack Function()? input,
    CoinStack Function()? machine,
    CoinStack Function()? output,
    String? Function()? displayMessage,
    Snack? Function()? selectedSnack,
  }) {
    // debugPrint("AppState.copyWith called");

    return AppState(
      availableSnacks: availableSnacks == null
          ? this.availableSnacks
          : availableSnacks(),
      input: input == null ? this.input : input(),
      machine: machine == null ? this.machine : machine(),
      output: output == null ? this.output : output(),
      displayMessage: displayMessage == null
          ? this.displayMessage
          : displayMessage(),
      selectedSnack: selectedSnack == null
          ? this.selectedSnack
          : selectedSnack(),
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
          input == other.input &&
          output == other.output &&
          machine == other.machine &&
          selectedSnack == other.selectedSnack &&
          displayMessage == other.displayMessage;

  @override
  int get hashCode =>
      availableSnacks.hashCode ^
      input.hashCode ^
      output.hashCode ^
      machine.hashCode ^
      selectedSnack.hashCode ^
      displayMessage.hashCode;

  @override
  String toString() {
    return 'AppState{availableSnacks: $availableSnacks, input: $input, output: $output, machine: $machine, selectedSnack: $selectedSnack, displayMessage: $displayMessage}';
  }

  /// Transform data to JSON
  Map<String, dynamic> toJson() => {
    'availableSnacks': availableSnacks.map((s) => s.toJson()).toList(),
    'input': input.toJson(),
    'output': output.toJson(),
    'machine': machine.toJson(),
    'displayMessage': displayMessage,
    'selectedSnack': selectedSnack?.toJson(),
  };

  /// Transform data from JSON
  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
    availableSnacks: (json['availableSnacks'] as List)
        .map((e) => Snack.fromJson(e as Map<String, dynamic>))
        .toList(),
    input: CoinStack.fromJson(json['input'] as Map<String, dynamic>),
    output: CoinStack.fromJson(json['output'] as Map<String, dynamic>),
    machine: CoinStack.fromJson(json['machine'] as Map<String, dynamic>),
    displayMessage: json['displayMessage'] as String?,
    selectedSnack: json['selectedSnack'] != null
        ? Snack.fromJson(json['selectedSnack'] as Map<String, dynamic>)
        : null,
  );
}
