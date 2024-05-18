import 'ConstructorVehiculo.dart';
import 'EstrategiaPersonalizacion.dart';
import 'Vehiculo.dart';

class Director {
  late ConstructorVehiculo constructor;
  late EstrategiaPersonalizacion estrategia;

  List<Vehiculo>? vehiculos;

  Director(newConstructor, newEstrategia) {
    if (newConstructor == null || newEstrategia == null) {
      throw ArgumentError('Constructor y estrategia no pueden ser nulos');
    }
    
    constructor = newConstructor;
    estrategia = newEstrategia;
    vehiculos = [];
  }

  void construirVehiculo() {
    constructor.crearVehiculo();
    constructor.configurarMotor();
    constructor.configurarRuedas();
    constructor.configurarCarroceria();
    constructor.configurarPersonalizacion(estrategia);
    vehiculos!.add(constructor.getVehiculo());
  }

  void setEstrategia(EstrategiaPersonalizacion newEstrategia) {
    estrategia = newEstrategia;
  }

  void setConstructor(ConstructorVehiculo newConstructor) {
    constructor = newConstructor;
  }

  List<Vehiculo> getVehiculos() {
    return vehiculos!;
  }
  

}
