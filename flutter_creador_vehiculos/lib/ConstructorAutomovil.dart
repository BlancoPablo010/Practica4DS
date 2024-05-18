import 'ConstructorVehiculo.dart';
//import 'Vehiculo.dart';

class ConstructorAutomovil extends ConstructorVehiculo {
  @override
  void configurarMotor() {
    vehiculo?.motor = 'motor de automóvil';
  }

  @override
  void configurarRuedas() {
    vehiculo?.ruedas = '4 ruedas';
  }

  @override
  void configurarCarroceria() {
    vehiculo?.carroceria = 'carrocería de automóvil';
  }
}
