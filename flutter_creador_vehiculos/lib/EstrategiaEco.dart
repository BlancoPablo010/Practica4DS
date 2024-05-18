import 'EstrategiaPersonalizacion.dart';
import 'Vehiculo.dart';

class EstrategiaEco extends EstrategiaPersonalizacion {
  @override
  void aplicar(Vehiculo vehiculo) {
    vehiculo.personalizacion = 'eco';
  }
}