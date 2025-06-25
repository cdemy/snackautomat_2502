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
