class TipoAnimal {
  static const Null = "";
  static const Cachorro = "Cachorro";
  static const Coelho = "Coelho";
  static const Gato = "Gato";
  static const Roedor = "Roedor";
  static const Outros = "Outros";

  List<String> toList() {
    return [
      Null,
      Cachorro,
      Coelho,
      Gato,
      Roedor,
      Outros
    ];
  }
}
