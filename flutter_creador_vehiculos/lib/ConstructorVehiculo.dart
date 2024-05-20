import 'EstrategiaPersonalizacion.dart';
import 'Vehiculo.dart';

abstract class ConstructorVehiculo {
  Vehiculo? vehiculo;

  void crearVehiculo() {
    vehiculo = Vehiculo();
  }

  void configurarMotor();
  void configurarRuedas();
  void configurarCarroceria();

  void configurarPersonalizacion(EstrategiaPersonalizacion estrategia) {
    estrategia.aplicar(vehiculo!);
  }

  void setUsuario(String usuario) {
    vehiculo?.usuario = usuario;
  }

  getVehiculo() {
    return vehiculo;
  }
}