// Class CoinStack with static coin values
class CoinStack {
  static const Set<int> potentialCoinValues = {1, 2, 5, 10, 20, 50, 100, 200};
  final Map<int, int> _coins;
  CoinStack(this._coins);

  // Returns access to coins (public map)
  Map<int, int> get coins => _coins;

  // Returns list of coins
  List<int> get asInts {
    List<int> result = [];
    for (var entry in _coins.entries) {
      for (int i = 0; i < entry.value; i++) {
        result.add(entry.key);
      }
    }
    return result;
  }

  // Returns the quantity of coins in stack
  int get amountOfCoins => _coins.values.fold(0, (sum, count) => sum + count);

  // Returns the value of the stack
  int get value {
    int totalSum = 0;
    for (var entry in _coins.entries) {
      totalSum += entry.key * entry.value;
    }
    return totalSum;
  }

  // Add the coin to the stack
  void addInt(int value) {
    if (!potentialCoinValues.contains(value)) return;
    _coins[value] = (_coins[value] ?? 0) + 1;
  }

  // Add coins to the stack
  void addInts(List<int> values) {
    for (var value in values) {
      addInt(value);
    }
  }

  // Remove the coin from the stack
  void removeInt(int value) {
    if (!potentialCoinValues.contains(value)) return;
    if ((_coins[value] ?? 0) <= 0) return;
    _coins[value] = (_coins[value] ?? 0) - 1;
  }

  // Remove coins from the stack
  void removeInts(List<int> values) {
    for (var value in values) {
      removeInt(value);
    }
  }

  void clear() {
    _coins.clear();
  }

  int countOfInts(int value) => _coins[value] ?? 0;

  bool containsInt(int value) {
    return _coins.containsKey(value) && _coins[value]! > 0;
  }

  bool isEmpty() => _coins.isEmpty;

  bool isNotEmpty() => !isEmpty();

  /*
  To compare 2 stacks we use Set.from method
  and check if keys (coin values) in both stacks are equal,
  then we compare values (quantity of each coin value) using the loop
  */
  bool isEqual(CoinStack other) {
    if (Set.from(coins.keys) != Set.from(other.coins.keys)) return false;
    for (var key in coins.keys) {
      if (coins[key] != other.coins[key]) return false;
    }
    return true;
  }

  bool isEqualValue(CoinStack other) {
    return value == other.value;
  }

  bool contains(CoinStack other) {
    for (var entry in other._coins.entries) {
      if ((_coins[entry.key] ?? 0) < entry.value) return false;
    }
    return true;
  }

  /*
  To be sure that we can give change (yes or no) we create variable (canGiveChange)
  where we store the needed value. Then we create a list (coinsBigToSmall)
  with coin values from big to small (200, 100, 50, etc.) to use it for GREEDY algorithm.
  Then we start a loop, where we go through the each coin value of the list.
  Inside the loop we create several variables, where we keep coins we have in our stack (availableCoins),
  coins we need for a change (neededCoins), and coins we actually use in the end (coinsToUse).
  Then we substract the value of coins we used from the change variable.
  If we reached zero, function returns TRUE (we succeed) or returns FALSE if we didn't.
  */
  bool canGiveChange(int value) {
    int changeToGive = value;
    List<int> coinsBigToSmall =
        _coins.keys.toList()
          ..sort((a, b) => b.compareTo(a)); // list of coins from big to small
    for (var coinValue in coinsBigToSmall) {
      int availableCoins = _coins[coinValue] ?? 0; //available coins in stack
      int neededCoins =
          changeToGive ~/ coinValue; //coins we could use to give change
      int coinsToUse =
          neededCoins <= availableCoins
              ? neededCoins
              : availableCoins; // we take coins that are available for us
      changeToGive -= coinsToUse * coinValue;
    }
    return changeToGive == 0;
  }

  /*
  To merge 2 stacks we create a new map using method Map.from, then we start a loop
  and go through the stack other. We add value of each key from other stack to merged stack
  and return new stack in the end.
  */
  CoinStack merge(CoinStack other) {
    Map<int, int> merged = Map.from(_coins); // do copy from stack this
    for (var entry in other._coins.entries) {
      merged[entry.key] = (merged[entry.key] ?? 0) + entry.value;
    }
    return CoinStack(merged);
  }

  /*
  To subract 2 stacks we create a new map, then start a loop and go through the stack other.
  We create 2 variable to see how many coins we have at the start and how many after subtraction
  and return new stack in the end. If coin count is below zero, we remove the coin.
  */
  CoinStack subtract(CoinStack other) {
    Map<int, int> result = Map.from(_coins);
    for (var entry in other._coins.entries) {
      int currentCount = result[entry.key] ?? 0;
      int newCount = currentCount - entry.value;
      if (newCount <= 0) {
        result.remove(entry.key);
      } else {
        result[entry.key] = newCount;
      }
    }
    return CoinStack(result);
  }

  /*
  To multiply a stack by a factor we create new map and start a loop. Inside the loop
  we multiply each coin by a factor and return result.
  */
  CoinStack multiply(int factor) {
    Map<int, int> result = {};
    for (var entry in _coins.entries) {
      result[entry.key] = entry.value * factor;
    }
    return CoinStack(result);
  }

  /*
  To divide a stack by a factor we firstly check if divisor bigger than 0. Then we
  create a new map and start a loop. Inside the loop we divide quantity of each coin
  by a factor and return result.
  */
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

  // Returns string representation for debugging
  @override
  String toString() {
    if (_coins.isEmpty) return 'CoinStack: empty';
    return 'CoinStack: $_coins (total: $value)';
  }
}
