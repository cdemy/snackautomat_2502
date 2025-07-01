import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snackautomat_2502/domain/state/app_notifier.dart';
import 'package:snackautomat_2502/theme/theme_extentions.dart';

class ProductsViewWidget extends ConsumerWidget {
  const ProductsViewWidget({super.key});

  /// Method to get the path to the product image
  String _getSnackImagePath(String snackId) {
    switch (snackId) {
      case '1':
        return 'assets/images/products/haribo_schluempfe.png';
      case '2':
        return 'assets/images/products/knoppers.png';
      case '3':
        return 'assets/images/products/lorenz_erdnuss.png';
      case '4':
        return 'assets/images/products/milka.png';
      case '5':
        return 'assets/images/products/paprika_chips.png';
      case '6':
        return 'assets/images/products/paulaner_spezi.png';
      case '7':
        return 'assets/images/products/potato_chips.png';
      case '8':
        return 'assets/images/products/sour_cream_onion_chips.png';
      case '9':
        return 'assets/images/products/tuc_cracker.png';

      /// Fallback image in case something is wrong
      default:
        return 'assets/images/products/default_snack.png';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Bei änderung wird ein Rebuild ausgelöst
    final appState = ref.watch(appNotifierProvider);
    final appNotifier = ref.read(appNotifierProvider.notifier);
    final availableSnacks =
        appState.availableSnacks; //Liste der verfügbaren Produkte
    final selected = appState.selectedSnack;

    const double cardAspectRatio = 0.75;
    const int crossAxisCount = 3;

    return Container(
      color: context.appColors.productsViewBackground,
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
                final bool isSoldOut =
                    snack.quantity == 0; // Wahr, wenn der Snack ausverkauft ist
                return GestureDetector(
                  onTap: () {
                    appNotifier.selectSnack(snack);
                  },
                  child: Card(
                    elevation: snack == selected ? 8 : 2,
                    color: isSoldOut
                        ? Colors.grey[300]
                        : context.appColors.productViewIconBackground,
                    shape: snack == selected
                        ? RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color(0xFF00E676),
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
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 8,
                              maxHeight: 250,
                            ),
                            // Gray filter applied to a product that is not available
                            child: ColorFiltered(
                              colorFilter: isSoldOut
                                  ? const ColorFilter.matrix(<double>[
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0.2126,
                                      0.7152,
                                      0.0722,
                                      0,
                                      0,
                                      0,
                                      0,
                                      0,
                                      1,
                                      0,
                                    ])
                                  // This filter does not change anything (used when the product is available)
                                  : const ColorFilter.mode(
                                      Colors.transparent,
                                      BlendMode.multiply,
                                    ),
                              child: Image.asset(
                                _getSnackImagePath(snack.id),
                              ),
                            ),
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
