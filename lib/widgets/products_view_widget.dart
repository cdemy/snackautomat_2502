import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackauotmat_2502/state/app_notifier.dart';
//import 'package:snackauotmat_2502/state/app_state.dart';
import 'package:snackauotmat_2502/state/cart_item.dart';

class ProductsViewWidget extends ConsumerWidget {
  const ProductsViewWidget({super.key});

  IconData _getSnackIcon(String snackName) {
    switch (snackName.toLowerCase()) {
      case 'kuchen':
        return Icons.cake_outlined;
      case 'chips':
        return Icons.local_mall;
      case 'cola':
        return Icons.local_drink;
      case 'wasser':
        return Icons.water_drop;
      case 'gummibärchen':
        return Icons.toys_outlined;
      case 'apfelsaft':
        return Icons.coffee;
      case 'sandwich':
        return Icons.lunch_dining;
      case 'müsliriegel':
        return Icons.energy_savings_leaf;
      case 'eistee':
        return Icons.icecream;
      default:
        return Icons.fastfood;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Bei änderung wird ein Rebuild ausgelöst
    final appState = ref.watch(appNotifierProvider);
    final appNotifier = ref.read(appNotifierProvider.notifier);

    final availableSnacks =
        appState.availableSnacks; //Liste der verfügbaren Produkte
    final cartItems = appState.cartItems; // Produkte im Warenkorb

    const double iconSize = 50.0;
    const double cardAspectRatio = 0.75;
    const int crossAxisCount = 3;

    return Container(
      color: Colors.blue[100], // Hintergrundfarbe des Produktbereichs
      padding: const EdgeInsets.all(8.0),
      child: availableSnacks.isEmpty
          ? const Center(
              // Wird angezeigt, wenn keine Snacks mehr da sind
              child: Text(
                'Keine Snacks verfügbar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: cardAspectRatio,
              ),
              itemCount: availableSnacks.length,
              itemBuilder: (context, index) {
                final snack = availableSnacks[index]; // Das aktuelle Produkt

                CartItem? currentCartItem;
                try {
                  currentCartItem = cartItems.firstWhere(
                    (item) => item.snack.id == snack.id,
                  );
                } catch (e) {
                  currentCartItem = null;
                }

                final int quantityInCart =
                    currentCartItem?.quantity ??
                    0; // Menge des Produkts im Warenkorb
                final bool isInCart =
                    quantityInCart > 0; // Wahr, wenn der Snack im Warenkorb ist
                final bool isSoldOut =
                    snack.quantity == 0; // Wahr, wenn der Snack ausverkauft ist

                return GestureDetector(
                  onTap: isSoldOut || quantityInCart >= snack.quantity
                      ? null // Wenn null, gibt es keine visuelle Reaktion auf Tap
                      : () => appNotifier.incrementSnackInCart(snack.id),
                  child: Card(
                    elevation: isInCart ? 8 : 2,
                    color: isSoldOut ? Colors.grey[300] : Colors.white,
                    shape: isInCart
                        ? RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          )
                        : RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                        8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            _getSnackIcon(
                              snack.name,
                            ),
                            size: iconSize,
                            color: isSoldOut
                                ? Colors.black26
                                : Theme.of(context).primaryColor,
                          ),
                          Text(
                            snack.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSoldOut
                                  ? Colors.black38
                                  : Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1, //
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${(snack.price / 100.0).toStringAsFixed(2)} €', // Preis in Euro
                            style: TextStyle(
                              fontSize: 14,
                              color: isSoldOut
                                  ? Colors.black38
                                  : Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isSoldOut
                                ? 'Ausverkauft'
                                : 'Verfügbar: ${snack.quantity}', // Verfügbare Menge
                            style: TextStyle(
                              fontSize: 12,
                              color: isSoldOut
                                  ? Colors.red[700]
                                  : Colors.black54,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_downward,
                                ), // Pfeil nach unten.
                                // Button deaktiviert, wenn Snack ausverkauft
                                onPressed: isSoldOut || quantityInCart == 0
                                    ? null
                                    : () => appNotifier.decrementSnackInCart(
                                        snack.id,
                                      ),
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              Text(
                                '$quantityInCart',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_upward,
                                ), // Pfeil nach oben
                                onPressed:
                                    isSoldOut ||
                                        quantityInCart >= snack.quantity
                                    ? null
                                    : () => appNotifier.incrementSnackInCart(
                                        snack.id,
                                      ),
                                iconSize: 20,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
