class Vehiculo {
  String? motor;
  String? ruedas;
  String? carroceria;
  String? personalizacion;

  @override
  String toString() {
    return 'Tiene $motor, $ruedas, $carroceria y modo motor $personalizacion';
  }
}