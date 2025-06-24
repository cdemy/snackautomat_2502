import 'dart:math';

/// Class CoinStack with static coin values
class CoinStack {
  static const Set<int> potentialCoinValues = {10, 20, 50, 100, 200};
  final Map<int, int> _coins;

  /// Regular constructor
  const CoinStack([this._coins = const {}]);

  /// Named constructor to create a stack with a single coin of the given value
  CoinStack.fromInt(int value)
    : _coins = {value: 1},
      assert(potentialCoinValues.contains(value), "CoinStack not valid");

  /// Return access to coins (public map)
  Map<int, int> get coins => Map.unmodifiable(_coins);

  /// Return list of coins
  List<int> get asInts {
    List<int> result = [];
    for (var entry in _coins.entries) {
      for (int i = 0; i < entry.value; i++) {
        result.add(entry.key);
      }
    }
    return result;
  }

  /// Return the quantity of coins in the stack
  int get amountOfCoins => _coins.values.fold(0, (sum, count) => sum + count);

  /// Return the value of the stack
  int get value {
    int totalSum = 0;
    for (var entry in _coins.entries) {
      totalSum += entry.key * entry.value;
    }
    return totalSum;
  }

  //TODO: Use a factory to implement random values
  /// Return a stack with random number of coins (20 to 50) of each value
  static CoinStack get random {
    final rand = Random();
    final coins = <int, int>{};
    for (var value in potentialCoinValues) {
      coins[value] = 20 + rand.nextInt(31);
    }
    return CoinStack(coins);
  }

  /// Gives a starting Stack of coins with 3 of each
  static const CoinStack firstCoins = CoinStack({
    1: 3,
    2: 3,
    5: 3,
    10: 3,
    20: 3,
    50: 3,
    100: 3,
    200: 3,
  });

  /// Return a copy of the current stack
  CoinStack copy() => CoinStack(Map.from(_coins));

  /// Add the coin to the stack
  CoinStack addInt(int value) => merge(CoinStack.fromInt(value));

  /// Add coins to the stack
  CoinStack addInts(List<int> values) {
    CoinStack coinStack = copy();
    for (var value in values) {
      coinStack = coinStack.addInt(value);
    }
    return coinStack;
  }

  /// Remove the coin from the stack
  CoinStack removeInt(int value) {
    if (!potentialCoinValues.contains(value)) {
      throw ArgumentError("Coin value not possible");
    }
    final result = copy().subtract(CoinStack.fromInt(value));
    return result;
  }

  /// Remove coins from the stack
  CoinStack removeInts(List<int> values) {
    CoinStack coinStack = copy();
    for (var value in values) {
      coinStack = coinStack.subtract(CoinStack.fromInt(value));
    }
    return coinStack;
  }

  /// Count the amount of all coins in the stack
  int countOfInts(int value) => _coins[value] ?? 0;

  /// Check if there is a particular coin in the stack
  bool containsInt(int value) {
    return _coins.containsKey(value) && _coins[value]! > 0;
  }

  /// Check if stack is empty
  bool isEmpty() => _coins.isEmpty;

  /// Check if stack is not empty
  bool isNotEmpty() => !isEmpty();

  /// To compare 2 stacks we use stack length and every() method
  /// and check if keys (coin values) in both stacks are equal,
  /// then we compare values (quantity of each coin value) using the loop

  bool isEqual(CoinStack other) {
    if (Set.from(coins.keys) != Set.from(other.coins.keys)) return false;
    for (var key in coins.keys) {
      if (coins[key] != other.coins[key]) return false;
    }
    return true;
  }

  /// Check if value of the first stack is equal to value of the second
  bool isEqualValue(CoinStack other) {
    return value == other.value;
  }

  /// Check if first stack contains the second inside
  bool contains(CoinStack other) {
    for (var entry in other._coins.entries) {
      if ((_coins[entry.key] ?? 0) < entry.value) return false;
    }
    return true;
  }

  /// To be sure that we can give change (yes or no) we create variable (canGiveChange)
  /// where we store the needed value. Then we create a list (coinsBigToSmall)
  /// with coin values from big to small (200, 100, 50, etc.) to use it for GREEDY algorithm.
  /// Then we start a loop, where we go through the each coin value of the list.
  /// Inside the loop we create several variables, where we keep coins we have in our stack (availableCoins),
  /// coins we need for a change (neededCoins), and coins we actually use in the end (coinsToUse).
  /// Then we substract the value of coins we used from the change variable.
  /// If we reached zero, function returns TRUE (we succeed) or returns FALSE if we didn't.

  bool canGiveChange(int value) {
    int changeToGive = value;
    List<int> coinsBigToSmall = _coins.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // list of coins from big to small
    for (var coinValue in coinsBigToSmall) {
      int availableCoins = _coins[coinValue] ?? 0; //available coins in stack
      int neededCoins =
          changeToGive ~/ coinValue; //coins we could use to give change
      int coinsToUse = neededCoins <= availableCoins
          ? neededCoins
          : availableCoins; // we take coins that are available for us
      changeToGive -= coinsToUse * coinValue;
    }
    return changeToGive == 0;
  }

  /// To calculate the actual change, we first check if we are able to give it using the method canGiveChange.
  /// If not — we return null (means: no change possible). Otherwise, we prepare an empty Map called result
  /// where we will store the coins we actually give as change.
  /// Then we create a list (coinsBigToSmall) with all coin values sorted from big to small (200, 100, 50, etc.).
  /// We go through this list using a loop and calculate how many coins we have (availableCoins),
  /// how many coins we need for the change (neededCoins), and how many we actually take (coinsToUse).
  /// If we take any coins (more than 0), we add them to the result stack and reduce the change amount.
  /// When the loop ends, we return a new CoinStack with the result Map — it contains all coins we give as change.

  CoinStack? giveChange(int value) {
    if (!canGiveChange(value)) return null;
    final result = <int, int>{}; // here we keep change stack
    int changeToGive = value;
    final coinsBigToSmall = _coins.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    for (final coinValue in coinsBigToSmall) {
      final availableCoins = _coins[coinValue] ?? 0; //available coins in stack
      final neededCoins =
          changeToGive ~/ coinValue; //coins we could use to give change
      final coinsToUse = neededCoins <= availableCoins
          ? neededCoins
          : availableCoins; // we take coins that are available for us (needed or available)
      if (coinsToUse > 0) {
        result[coinValue] = coinsToUse;
        changeToGive -= coinsToUse * coinValue;
      }
    }
    return CoinStack(result);
  }

  /// To merge 2 stacks we create a new map using method Map.from, then we start a loop
  /// and go through the stack other. We add value of each key from other stack to merged stack
  /// and return new stack in the end.

  CoinStack merge(CoinStack other) {
    Map<int, int> merged = Map.from(_coins); // do copy from stack this
    for (var entry in other._coins.entries) {
      merged[entry.key] = (merged[entry.key] ?? 0) + entry.value;
    }
    return CoinStack(merged);
  }

  /// To subract 2 stacks we create a new map, then start a loop and go through the stack other.
  /// We create 2 variable to see how many coins we have at the start and how many after subtraction
  /// and return new stack in the end. If coin count is below zero, we remove the coin.

  CoinStack subtract(CoinStack other) {
    Map<int, int> result = Map.from(_coins);
    for (var entry in other._coins.entries) {
      int currentCount = result[entry.key] ?? 0;
      int newCount = currentCount - entry.value;
      if (newCount == 0) {
        result.remove(entry.key);
      } else if (newCount < 0) {
        throw ArgumentError("Tried to subtract a coin which isn't there");
      } else {
        result[entry.key] = newCount;
      }
    }
    return CoinStack(result);
  }

  /// To multiply a stack by a factor we create new map and start a loop. Inside the loop
  /// we multiply each coin by a factor and return result.

  CoinStack multiply(int factor) {
    Map<int, int> result = {};
    for (var entry in _coins.entries) {
      result[entry.key] = entry.value * factor;
    }
    return CoinStack(result);
  }

  /// To divide a stack by a factor we firstly check if divisor bigger than 0. Then we
  /// create a new map and start a loop. Inside the loop we divide quantity of each coin
  /// by a factor and return result.

  CoinStack divide(int factor) {
    if (factor <= 0) return this;
    Map<int, int> result = {};
    for (var entry in _coins.entries) {
      int newCount = entry.value ~/ factor;
      if (newCount > 0) {
        result[entry.key] = newCount;
      }
    }
    return CoinStack(result);
  }

  /// Return string representation for debugging
  @override
  String toString() {
    if (_coins.isEmpty) return 'CoinStack: empty';
    return 'CoinStack: $_coins (total: $value)';
  }

  /// Transform data to JSON
  Map<String, dynamic> toJson() {
    final jsonMap = <String, dynamic>{};
    for (final entry in _coins.entries) {
      jsonMap[entry.key.toString()] = entry.value;
    }
    return jsonMap;
  }

  /// Transform data from JSON
  factory CoinStack.fromJson(Map<String, dynamic> json) {
    final coinMap = <int, int>{};
    for (final entry in json.entries) {
      final key = int.parse(entry.key);
      final value = entry.value as int;
      coinMap[key] = value;
    }
    return CoinStack(coinMap);
  }
}
