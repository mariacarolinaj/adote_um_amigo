class TipoAnimal {
  static const Null = "";
  static const Cachorro = "Cachorro";
  static const Gato = "Gato";
  static const Roedor = "Roedor";
  static const Outros = "Outros";

  List<String> toList() {
    return [Null, Cachorro, Gato, Roedor, Outros];
  }
}
