import 'package:flutter/foundation.dart';
import 'package:snackautomat_2502/models/snack.dart';
import 'package:snackautomat_2502/models/coinstack.dart';

@immutable // Klasse kann nicht verändert werden
class AppState {
  final List<Snack> availableSnacks;
  final CoinStack input;
  final CoinStack machine;
  final CoinStack output;
  final CoinStack wallet;
  final Snack? selectedSnack;

  const AppState({
    this.availableSnacks = const [],
    this.input = const CoinStack(),
    this.machine = const CoinStack(),
    this.output = const CoinStack(),
    this.wallet = const CoinStack(),
    this.selectedSnack,
  });

  AppState copyWith({
    List<Snack> Function()? availableSnacks,
    List<Snack> Function()? cartItems,
    CoinStack Function()? input,
    CoinStack Function()? machine,
    CoinStack Function()? output,
    CoinStack Function()? wallet,
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
      wallet: wallet == null ? this.wallet : wallet(),
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
          machine == other.machine;

  @override
  int get hashCode =>
      availableSnacks.hashCode ^
      input.hashCode ^
      output.hashCode ^
      machine.hashCode;

  @override
  String toString() {
    return 'AppState{availableSnacks: $availableSnacks, input: $input, output: $output, machine: $machine}';
  }
}

  //.toJson() and .fromJson()
  Map<String, dynamic> toJson() => {
    'availableSnacks': availableSnacks.map((s) => s.toJson()).toList(),
    'input': input.toJson(),
    'output': output.toJson(),
    'machine': machine.toJson(),
    'wallet': wallet.toJson(),
    'selectedSnack': selectedSnack?.toJson(),
  };

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
    availableSnacks: (json['availableSnacks'] as List)
        .map((e) => Snack.fromJson(e as Map<String, dynamic>))
        .toList(),
    input: CoinStack.fromJson(json['input'] as Map<String, dynamic>),
    output: CoinStack.fromJson(json['output'] as Map<String, dynamic>),
    machine: CoinStack.fromJson(json['machine'] as Map<String, dynamic>),
    wallet: CoinStack.fromJson(json['wallet'] as Map<String, dynamic>),
    selectedSnack: json['selectedSnack'] != null
        ? Snack.fromJson(json['selectedSnack'] as Map<String, dynamic>)
        : null,
  );