import 'ConstructorVehiculo.dart';
//import 'Vehiculo.dart';

class ConstructorCamion extends ConstructorVehiculo {
  @override
  void configurarMotor() {
    vehiculo?.motor = 'motor de camión';
  }

  @override
  void configurarRuedas() {
    vehiculo?.ruedas = '8 ruedas';
  }

  @override
  void configurarCarroceria() {
    vehiculo?.carroceria = 'carrocería de camión';
  }
}
