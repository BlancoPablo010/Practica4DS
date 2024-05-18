import 'EstrategiaPersonalizacion.dart';
import 'Vehiculo.dart';

class EstrategiaDeportiva extends EstrategiaPersonalizacion {
  @override
  void aplicar(Vehiculo vehiculo) {
    vehiculo.personalizacion = 'deportivo';
  }
}