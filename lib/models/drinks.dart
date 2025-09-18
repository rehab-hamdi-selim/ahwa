abstract class Drink {
  String get name;
  double get price;
}

class ShaiDrink implements Drink {
  @override
  String get name => 'Shai (Tea)';

  @override
  double get price => 10;
}

class TurkishCoffeeDrink implements Drink {
  @override
  String get name => 'Turkish coffee';

  @override
  double get price => 25;
}

class HibiscusTeaDrink implements Drink {
  @override
  String get name => 'Hibiscus tea';

  @override
  double get price => 15;
}
