import '../domain/catalog_models.dart';

class DemoCatalogRepository implements CatalogRepository {
  const DemoCatalogRepository();

  static const _suppliers = <Supplier>[
    Supplier(
      id: 'kws',
      name: 'Kazakhstan W&S',
      caption: 'Вино и крепкие напитки',
      category: 'Алкоголь',
      brand: SupplierBrand.kws,
      deliveryLabel: 'ближайшая доставка',
    ),
    Supplier(
      id: 'coca-cola',
      name: 'Coca-Cola',
      caption: 'Напитки и вода',
      category: 'Напитки',
      brand: SupplierBrand.cocaCola,
      deliveryLabel: 'ближайшая доставка',
    ),
    Supplier(
      id: 'pepsi',
      name: 'PepsiCo',
      caption: 'Напитки и снеки',
      category: 'Напитки',
      brand: SupplierBrand.pepsi,
      deliveryLabel: 'ближайшая доставка',
    ),
  ];

  static const _products = <Product>[
    Product(
      id: 'bushmills-original-05',
      supplierId: 'kws',
      name: 'Bushmills Original',
      subtitle: 'Ирландский виски · 40%',
      brand: 'BUSHMILLS',
      section: CatalogSection.spirits,
      volume: '0,5 л',
      price: 10200,
    ),
    Product(
      id: 'bushmills-original-07',
      supplierId: 'kws',
      name: 'Bushmills Original',
      subtitle: 'Ирландский виски · 40%',
      brand: 'BUSHMILLS',
      section: CatalogSection.spirits,
      volume: '0,7 л',
      price: 12800,
    ),
    Product(
      id: 'bushmills-original-10',
      supplierId: 'kws',
      name: 'Bushmills Original',
      subtitle: 'Ирландский виски · 40%',
      brand: 'BUSHMILLS',
      section: CatalogSection.spirits,
      volume: '1 л',
      price: 17800,
    ),
    Product(
      id: 'bushmills-black-bush-07',
      supplierId: 'kws',
      name: 'Bushmills Black Bush',
      subtitle: 'Ирландский виски · 40%',
      brand: 'BUSHMILLS',
      section: CatalogSection.spirits,
      volume: '0,7 л',
      price: 14500,
      oldPrice: 16200,
    ),
    Product(
      id: 'hennessy-vs-07',
      supplierId: 'kws',
      name: 'Hennessy VS',
      subtitle: 'Cognac AOC · 40%',
      brand: 'HENNESSY',
      section: CatalogSection.spirits,
      volume: '0,7 л',
      price: 25500,
    ),
    Product(
      id: 'belvedere-07',
      supplierId: 'kws',
      name: 'Belvedere Organic Vodka',
      subtitle: 'Польша · 40%',
      brand: 'BELVEDERE',
      section: CatalogSection.spirits,
      volume: '0,7 л',
      price: 20000,
    ),
    Product(
      id: 'moet-imperial-075',
      supplierId: 'kws',
      name: 'Moët & Chandon Impérial',
      subtitle: 'Champagne · белое сухое',
      brand: 'MOËT & CHANDON',
      section: CatalogSection.wine,
      volume: '0,75 л',
      price: 38000,
    ),
    Product(
      id: 'veuve-brut-075',
      supplierId: 'kws',
      name: 'Veuve Clicquot Brut',
      subtitle: 'Champagne · белое сухое',
      brand: 'VEUVE CLICQUOT',
      section: CatalogSection.wine,
      volume: '0,75 л',
      price: 45000,
    ),
    Product(
      id: 'coke-05',
      supplierId: 'coca-cola',
      name: 'Coca-Cola Original',
      subtitle: 'Газированный напиток',
      brand: 'COCA-COLA',
      section: CatalogSection.softDrinks,
      volume: '0,5 л',
      price: 450,
    ),
    Product(
      id: 'coke-10',
      supplierId: 'coca-cola',
      name: 'Coca-Cola Original',
      subtitle: 'Газированный напиток',
      brand: 'COCA-COLA',
      section: CatalogSection.softDrinks,
      volume: '1 л',
      price: 650,
      oldPrice: 720,
    ),
    Product(
      id: 'sprite-10',
      supplierId: 'coca-cola',
      name: 'Sprite',
      subtitle: 'Лимон-лайм',
      brand: 'SPRITE',
      section: CatalogSection.softDrinks,
      volume: '1 л',
      price: 650,
    ),
    Product(
      id: 'pepsi-05',
      supplierId: 'pepsi',
      name: 'Pepsi',
      subtitle: 'Газированный напиток',
      brand: 'PEPSI',
      section: CatalogSection.softDrinks,
      volume: '0,5 л',
      price: 430,
    ),
    Product(
      id: 'pepsi-10',
      supplierId: 'pepsi',
      name: 'Pepsi',
      subtitle: 'Газированный напиток',
      brand: 'PEPSI',
      section: CatalogSection.softDrinks,
      volume: '1 л',
      price: 620,
    ),
    Product(
      id: 'seven-up-10',
      supplierId: 'pepsi',
      name: '7UP',
      subtitle: 'Лимон-лайм',
      brand: '7UP',
      section: CatalogSection.softDrinks,
      volume: '1 л',
      price: 620,
    ),
  ];

  @override
  List<Supplier> get suppliers => _suppliers;

  @override
  List<Product> productsFor(String supplierId) => _products
      .where((product) => product.supplierId == supplierId)
      .toList(growable: false);

  @override
  Product productById(String id) =>
      _products.firstWhere((product) => product.id == id);

  @override
  Supplier supplierById(String id) =>
      _suppliers.firstWhere((supplier) => supplier.id == id);
}
