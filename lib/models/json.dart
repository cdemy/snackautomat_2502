/*
Bedienungsanleitung

import 'dart:convert'; erforderlich bei verwendung der Methoden json.encode() oder json.decode()

Beispiel: Produkt in JSON-String konvertieren
String jsonString = json.encode(ProductSerializer.toJson(product));

Beispiel: JSON-String wieder in Produkt umwandeln
Product product = ProductSerializer.fromJson(json.decode(jsonString));

Product product = Product(
  name: 'Hanuta',
  url: 'https://xyz.de/hanuta',
  price: 90,
  amount: 3,
);

Map<String, dynamic> jsonMap = ProductSerializer.toJson(product);

Product product = ProductSerializer.fromJson(jsonMap);

optional:
String jsonString = '{"name":"Hanuta","url":"https://xyz.de/hanuta","price":90,"amount":3}';
Map<String, dynamic> jsonMap = json.decode(jsonString);
Product product = ProductSerializer.fromJson(jsonMap);

Die Serialisierung von Listen bedeutet in diesem Zusammenhang, dass du eine Liste von Product-Objekten
in eine JSON-kompatible Struktur umwandelst – meistens eine List<Map<String, dynamic>> – und umgekehrt.


Liste von Produkten zu JSON konvertieren:
static List<Map<String, dynamic>> listToJson(List<Product> products) {
  return products.map((product) => toJson(product)).toList();
}

Verwendung:
List<Product> products = [
  Product(name: 'Hanuta', url: 'https://xyz.de/hanuta', price: 90, amount: 2),
  Product(name: 'Cola', url: 'https://xyz.de/cola', price: 150, amount: 1),
];

List<Map<String, dynamic>> jsonList = ProductSerializer.listToJson(products);
String jsonString = json.encode(jsonList); // optional

JSON zu Liste von Produkten konvertieren:
static List<Product> listFromJson(List<dynamic> jsonList) {
  return jsonList.map((item) => fromJson(item)).toList();
}


Verwendung:
String jsonString = '[{"name":"Hanuta","url":"https://xyz.de/hanuta","price":90,"amount":3},{"name":"Cola","url":"https://xyz.de/cola","price":150,"amount":1}]';
List<dynamic> jsonList = json.decode(jsonString);

List<Product> products = ProductSerializer.listFromJson(jsonList);


häufigeyy Fehlerquellen bei der Serialisierung

1. Falsche oder fehlende Typkonvertierung
Wenn ein Wert aus der JSON-Map nicht den erwarteten Typ hat (z. B. double statt int), führt das oft zu Laufzeitfehlern.

Tipp: Verwende defensives Programmieren oder sichere Typumwandlungen (as int? ?? 0, int.tryParse()).

2. Fehlende Felder in der JSON-Map
Wenn du annimmst, dass alle Felder vorhanden sind, aber z. B. "price" fehlt, kann dein Code abstürzen.
price: json['price'] as int? ?? 0,

3. JSON-Format nicht wie erwartet
Vielleicht bekommst du eine Liste von Objekten, aber rechnest mit einem einzelnen Objekt – oder umgekehrt.

Tipp: Immer zuerst prüfen, ob es sich um Map oder List handelt, z. B.:
if (jsonData is List) {
//Liste verarbeiten
}

Wenn zwei Klassen sich gegenseitig enthalten, kann das zu Endlosschleifen führen.

5. Null-Werte nicht behandelt
null-Werte können auftreten, wenn z. B. ein API-Feld weggelassen wurde.

Tipp: Prüfe bei der Deserialisierung auf null und gib Standardwerte zurück
*/

import 'product.dart';
//import 'dart:convert';

class ProductSerializer {
  /// Konvertiert ein Produkt Objekt zu einer JSON-Map.
  static Map<String, dynamic> toJson(Product product) {
    return {
      'name': product.name,
      'url': product.url,
      'price': product.price, // Bleibt int
      'amount': product.amount,
    };
  }

  /// Erstellt ein Produkt Objekt aus einer JSON-Map.
  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      url: json['url'] as String,
      price: json['price'] as int, // Bleibt int
      amount: json['amount'] as int,
    );
  }
}

/*
Speichern:
zwei Boxen: eine für die Produkte, eine für den CoinStack.

Product: s.o.

CoinStack = Map<int, int>; // z. B. {5: 4, 10: 3} für 4x5 ct, 3x10 ct

Future<void> saveState(List<Product> products, CoinStack coins) async {
  var productBox = await Hive.openBox('products');
  var coinsBox = await Hive.openBox('coins');

  await productBox.put('products', ProductSerializer.listToJson(products));
  await coinsBox.put('coins', coins);
}


Wiederherstellen:

Future<(List<Product>, CoinStack)> loadState() async {
  var productBox = await Hive.openBox('products');
  var coinsBox = await Hive.openBox('coins');

  var productsRaw = productBox.get('items', defaultValue: []);
  var products = ProductSerializer.listFromJson(List<Map<String, dynamic>>.from(productsRaw));

  var coinStack = Map<int, int>.from(coinsBox.get('stack', defaultValue: {}));

  return (products, coinStack);
}

*/
