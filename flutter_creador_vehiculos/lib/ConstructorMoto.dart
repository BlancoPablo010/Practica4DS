import 'ConstructorVehiculo.dart';
// import 'EstrategiaPersonalizacion.dart';
// import 'Vehiculo.dart';

class ConstructorMoto extends ConstructorVehiculo {
  @override
  void configurarMotor() {
    vehiculo?.motor = 'motor de moto';
  }

  @override
  void configurarRuedas() {
    vehiculo?.ruedas = '2 ruedas';
  }

  @override
  void configurarCarroceria() {
    vehiculo?.carroceria = 'carrocería de moto';
  }
}
