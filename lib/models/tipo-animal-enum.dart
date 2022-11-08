class TipoAnimal {
  static const Null = "";
  static const Anfibio = "Anfíbio";
  static const Cachorro = "Cachorro";
  static const Coelho = "Coelho";
  static const Gato = "Gato";
  static const Peixe = "Peixe";
  static const Reptil = "Réptil";
  static const Roedor = "Roedor";
  static const Outros = "Outros";

  List<String> toList() {
    return [
      Null,
      Anfibio,
      Cachorro,
      Coelho,
      Gato,
      Peixe,
      Reptil,
      Roedor,
      Outros
    ];
  }
}
