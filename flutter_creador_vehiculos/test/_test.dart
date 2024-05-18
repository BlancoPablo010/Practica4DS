import 'package:flutter_creador_vehiculos/ConstructorVehiculo.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_creador_vehiculos/Director.dart';
import 'package:flutter_creador_vehiculos/ConstructorMoto.dart';
import 'package:flutter_creador_vehiculos/ConstructorAutomovil.dart';
import 'package:flutter_creador_vehiculos/ConstructorCamion.dart';
import 'package:flutter_creador_vehiculos/Vehiculo.dart';
import 'package:flutter_creador_vehiculos/EstrategiaPersonalizacion.dart';
import 'package:flutter_creador_vehiculos/EstrategiaEco.dart';
import 'package:flutter_creador_vehiculos/EstrategiaDeportiva.dart';


void main() {
  group('Grupo 1 - Creaciones de objetos', () {
    test('Test 1 - Creación correcta de director', () {
      // Test code for MyClass1

      Director director = Director(ConstructorMoto(), EstrategiaEco());
      expect(director, isNotNull);
    });

    test('Test 2 - Creación de director sin constructor', () {

      expect(() => Director(null, EstrategiaEco()), throwsArgumentError);
    });

    test('Test 3 - Creación de director sin estrategia', () {

      expect(() => Director(ConstructorMoto(), null), throwsArgumentError);
    });

    test('Test 4 - Creación de todos los builders', () {
      // Crear un constructor de moto
      ConstructorMoto constructorMoto = ConstructorMoto();
      // Crear un constructor de automóvil
      ConstructorAutomovil constructorAutomovil = ConstructorAutomovil();
      // Crear un constructor de camión
      ConstructorCamion constructorCamion = ConstructorCamion();

      // Verificar que los constructores no son nulos
      expect(constructorMoto, isNotNull);
      expect(constructorAutomovil, isNotNull);
      expect(constructorCamion, isNotNull);
    });

    test('Test 5 - Creación de todas las estrategias', () {
      // Crear una estrategia de personalización ecológica
      EstrategiaPersonalizacion estrategiaEco = EstrategiaEco();
      // Crear una estrategia de personalización deportiva
      EstrategiaPersonalizacion estrategiaDeportiva = EstrategiaDeportiva();

      // Verificar que las estrategias no son nulas
      expect(estrategiaEco, isNotNull);
      expect(estrategiaDeportiva, isNotNull);
    });

    test('Test 6 - Creación de vehículos y son diferentes', () {
      // Crear dos constructores de automóviles
      Director director = Director(ConstructorAutomovil(), EstrategiaEco());

      // Crear dos vehiculos
      director.construirVehiculo();

      director.setConstructor(ConstructorMoto());

      director.construirVehiculo();

      Vehiculo vehiculo1 = director.getVehiculos()[0];
      Vehiculo vehiculo2 = director.getVehiculos()[1];

      // Verificar que los vehículos son diferentes objetos
      expect(identical(vehiculo1, vehiculo2), isFalse);
    });
  });

  group('Grupo 2 - Validaciones', () {
    test('Test 1 - Prueba de creación de vehículos con diferentes constructores', () {
      // Crear un constructor de moto
      ConstructorMoto constructorMoto = ConstructorMoto();
      // Crear un constructor de automóvil
      ConstructorAutomovil constructorAutomovil = ConstructorAutomovil();
      // Crear un constructor de camión
      ConstructorCamion constructorCamion = ConstructorCamion();

      // Crear un director con el constructor de moto
      Director director = Director(constructorMoto, EstrategiaEco());

      // Crear un vehículo utilizando el constructor de moto
      director.construirVehiculo();

      // Crear un vehículo utilizando el constructor de automóvil
      director.setConstructor(constructorAutomovil);
      director.construirVehiculo();

      // Crear un vehículo utilizando el constructor de camión
      director.setConstructor(constructorCamion);
      director.construirVehiculo();

      // Verificar que los vehículos son de los tipos correctos
      expect(director.getVehiculos()[0].motor, 'motor de moto');
      expect(director.getVehiculos()[1].motor, 'motor de automóvil');
      expect(director.getVehiculos()[2].motor, 'motor de camión');
    });

    test('Test 2 - Cambio correcto de estrategia', () {

      EstrategiaPersonalizacion estrategiaDeportiva = EstrategiaDeportiva();
      EstrategiaPersonalizacion estrategiaEco = EstrategiaEco();

      Director director = Director(ConstructorMoto(), estrategiaEco);

      expect(director, isNotNull);
      expect(director.estrategia, estrategiaEco);

      director.setEstrategia(estrategiaDeportiva);

      expect(director.estrategia, estrategiaDeportiva);

    });

    test('Test 3 - Prueba de configuración de estrategia de personalización', () {
      // Crear una estrategia de personalización ecológica
      EstrategiaPersonalizacion estrategiaEco = EstrategiaEco();
      // Crear una estrategia de personalización deportiva
      EstrategiaPersonalizacion estrategiaDeportiva = EstrategiaDeportiva();

      // Crear un constructor de moto
      ConstructorMoto constructorMoto = ConstructorMoto();
      // Crear un constructor de automóvil
      ConstructorAutomovil constructorAutomovil = ConstructorAutomovil();
      // Crear un constructor de camión
      ConstructorCamion constructorCamion = ConstructorCamion();

      // Crear un director con el constructor de moto y la estrategia ecológica
      Director director = Director(constructorMoto, estrategiaEco);

      // Crear un vehículo utilizando el constructor de moto
      director.construirVehiculo();

      // Crear un vehículo utilizando el constructor de automóvil
      director.setConstructor(constructorAutomovil);
      director.construirVehiculo();

      // Crear un vehículo utilizando el constructor de camión
      director.setConstructor(constructorCamion);
      director.construirVehiculo();

      // Verificar que los vehículos tienen la personalización correcta
      expect(director.getVehiculos()[0].personalizacion, 'eco');
      expect(director.getVehiculos()[1].personalizacion, 'eco');
      expect(director.getVehiculos()[2].personalizacion, 'eco');

      // Cambiar la estrategia de personalización a deportiva
      director.setEstrategia(estrategiaDeportiva);

      // Crear un vehículo utilizando el constructor de moto
      director.construirVehiculo();

      // Crear un vehículo utilizando el constructor de automóvil
      director.setConstructor(constructorAutomovil);
      director.construirVehiculo();

      // Crear un vehículo utilizando el constructor de camión
      director.setConstructor(constructorCamion);
      director.construirVehiculo();

      // Verificar que los vehículos tienen la personalización correcta
      expect(director.getVehiculos()[3].personalizacion, 'deportivo');
      expect(director.getVehiculos()[4].personalizacion, 'deportivo');
      expect(director.getVehiculos()[5].personalizacion, 'deportivo');
    });

    test('Test 4 - Representación correcta de Vehículo', () {
      ConstructorVehiculo constructorMoto = ConstructorMoto();
      ConstructorVehiculo constructorAutomovil = ConstructorAutomovil();
      ConstructorVehiculo constructorCamion = ConstructorCamion();

      EstrategiaPersonalizacion estrategiaEco = EstrategiaEco();
      EstrategiaPersonalizacion estrategiaDeportiva = EstrategiaDeportiva();

      Director director = Director(constructorMoto, estrategiaEco);

      director.construirVehiculo();

      expect(director.getVehiculos()[0].toString(), 'Tiene motor de moto, 2 ruedas, carrocería de moto y modo motor eco');

      director.setConstructor(constructorAutomovil);
      director.construirVehiculo();

      expect(director.getVehiculos()[1].toString(), 'Tiene motor de automóvil, 4 ruedas, carrocería de automóvil y modo motor eco');

      director.setConstructor(constructorCamion);
      director.construirVehiculo();

      expect(director.getVehiculos()[2].toString(), 'Tiene motor de camión, 8 ruedas, carrocería de camión y modo motor eco');

      director.setEstrategia(estrategiaDeportiva);
      director.setConstructor(constructorMoto);
      director.construirVehiculo();

      expect(director.getVehiculos()[3].toString(), 'Tiene motor de moto, 2 ruedas, carrocería de moto y modo motor deportivo');

      director.setConstructor(constructorAutomovil);
      director.construirVehiculo();

      expect(director.getVehiculos()[4].toString(), 'Tiene motor de automóvil, 4 ruedas, carrocería de automóvil y modo motor deportivo');

      director.setConstructor(constructorCamion);
      director.construirVehiculo();

      expect(director.getVehiculos()[5].toString(), 'Tiene motor de camión, 8 ruedas, carrocería de camión y modo motor deportivo');
      
    });

    test('Test 5 - Comprobar que todas las partes son correctas', () {

      ConstructorVehiculo constructorMoto = ConstructorMoto();
      ConstructorVehiculo constructorAutomovil = ConstructorAutomovil();
      ConstructorVehiculo constructorCamion = ConstructorCamion();

      EstrategiaPersonalizacion estrategiaEco = EstrategiaEco();
      EstrategiaPersonalizacion estrategiaDeportiva = EstrategiaDeportiva();

      Director director = Director(constructorMoto, estrategiaEco);

      director.construirVehiculo();

      director.setConstructor(constructorAutomovil);

      director.construirVehiculo();

      director.setConstructor(constructorCamion);

      director.construirVehiculo();

      expect(director.getVehiculos()[0].motor, 'motor de moto');
      expect(director.getVehiculos()[0].ruedas, '2 ruedas');
      expect(director.getVehiculos()[0].carroceria, 'carrocería de moto');
      expect(director.getVehiculos()[0].personalizacion, 'eco');

      expect(director.getVehiculos()[1].motor, 'motor de automóvil');
      expect(director.getVehiculos()[1].ruedas, '4 ruedas');
      expect(director.getVehiculos()[1].carroceria, 'carrocería de automóvil');
      expect(director.getVehiculos()[1].personalizacion, 'eco');

      expect(director.getVehiculos()[2].motor, 'motor de camión');
      expect(director.getVehiculos()[2].ruedas, '8 ruedas');
      expect(director.getVehiculos()[2].carroceria, 'carrocería de camión');
      expect(director.getVehiculos()[2].personalizacion, 'eco');

      director.setEstrategia(estrategiaDeportiva);

      director.setConstructor(constructorMoto);

      director.construirVehiculo();

      director.setConstructor(constructorAutomovil);

      director.construirVehiculo();

      director.setConstructor(constructorCamion);

      director.construirVehiculo();

      expect(director.getVehiculos()[3].motor, 'motor de moto');
      expect(director.getVehiculos()[3].ruedas, '2 ruedas');
      expect(director.getVehiculos()[3].carroceria, 'carrocería de moto');
      expect(director.getVehiculos()[3].personalizacion, 'deportivo');

      expect(director.getVehiculos()[4].motor, 'motor de automóvil');
      expect(director.getVehiculos()[4].ruedas, '4 ruedas');
      expect(director.getVehiculos()[4].carroceria, 'carrocería de automóvil');
      expect(director.getVehiculos()[4].personalizacion, 'deportivo');

      expect(director.getVehiculos()[5].motor, 'motor de camión');
      expect(director.getVehiculos()[5].ruedas, '8 ruedas');
      expect(director.getVehiculos()[5].carroceria, 'carrocería de camión');
      expect(director.getVehiculos()[5].personalizacion, 'deportivo');
    });

    test('Test 6 - Guardado en la lista de manera correcta', () {

      Director director = Director(ConstructorMoto(), EstrategiaEco());

      for (int i=0; i<10; i++) {
        director.construirVehiculo();
      }

      expect(director.getVehiculos().length, 10);
    });

  });
}