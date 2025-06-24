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
*/

//import 'dart:convert';

class Product {
  final String name;
  final String url;
  final int price;
  final int amount;

  Product({
    required this.name,
    required this.url,
    required this.price,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'price': price,
      'amount': amount,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      url: map['url'] as String,
      price: map['price'] as int,
      amount: map['amount'] as int,
    );
  }
}

class ProductSerializer {
  static Map<String, dynamic> toJson(Product product) {
    return product.toMap();
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product.fromMap(json);
  }

  static List<Map<String, dynamic>> listToJson(List<Product> products) {
    return products.map((product) => toJson(product)).toList();
  }

  static List<Product> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
