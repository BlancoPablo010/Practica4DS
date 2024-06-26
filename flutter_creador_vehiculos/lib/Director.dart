import 'ConstructorVehiculo.dart';
import 'EstrategiaPersonalizacion.dart';
import 'package:http/http.dart' as http;
import 'Vehiculo.dart';
import 'dart:convert';

class Director {
  late ConstructorVehiculo constructor;
  late EstrategiaPersonalizacion estrategia;

  List<Vehiculo>? vehiculos;
  final String apiUrlvehiculo= "http://localhost:3000/vehiculo";
  final String apiUrlusuario= "http://localhost:3000/usuario";
  List<String> usuarios = [];
  String currentUser = "";


  Director(newConstructor, newEstrategia) {
    if (newConstructor == null || newEstrategia == null) {
      throw ArgumentError('Constructor y estrategia no pueden ser nulos');
    }
    
    constructor = newConstructor;
    estrategia = newEstrategia;
    vehiculos = [];
    usuarios = [];
    currentUser = "";
  }

  Vehiculo construirVehiculo() {
    constructor.crearVehiculo();
    constructor.configurarMotor();
    constructor.configurarRuedas();
    constructor.configurarCarroceria();
    constructor.configurarPersonalizacion(estrategia);
    constructor.setUsuario(currentUser);

    return constructor.getVehiculo();
  }

  void setEstrategia(EstrategiaPersonalizacion newEstrategia) {
    estrategia = newEstrategia;
  }

  void setConstructor(ConstructorVehiculo newConstructor) {
    constructor = newConstructor;
  }

  void setCurrentUser(String user){
    currentUser = user;
  }


  List<Vehiculo> getVehiculos() {
    return vehiculos!;
  }

  List<String> getUsuarios(){
    return usuarios;
  }

  String getCurrentUser(){
    return currentUser;
  }
  
  Future<void> cargarVehiculos() async{ 
    final respuesta = await http.get(Uri.parse('$apiUrlvehiculo?usuario=$currentUser'));

    if (respuesta.statusCode == 200) {
        List<dynamic> vehiculosJson = json.decode(respuesta.body);

        vehiculos?.clear();
        vehiculos?.addAll(vehiculosJson.map((json) => Vehiculo.fromJson(json)).toList());
    }
    else{
      throw Exception('Error a la hora de cargar los vehiculos');
    }

  }

  Future<void> agregar(Vehiculo vehiculo) async {
    final respuesta = await http.post(
      Uri.parse(apiUrlvehiculo), 
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(vehiculo.toJson()),
    );

    if(respuesta.statusCode == 201){
      vehiculos?.add(Vehiculo.fromJson(json.decode(respuesta.body)));
    }
    else{
      throw Exception('Error al añadir el vehiculo: ${respuesta.body}');
    }
  }

  Future <void> eliminar(Vehiculo vehiculo) async {
    final respuesta = await http.delete(
      Uri.parse('$apiUrlvehiculo/${vehiculo.id}'),
    );

    if(respuesta.statusCode == 200) {
      vehiculos?.removeWhere((v) => v.id == vehiculo.id);
    }
    else{
      throw Exception('Error al eliminar el vehiculo');
    }
  }

  Future<void> cargarUsuarios() async {
    final respuesta = await http.get(Uri.parse(apiUrlusuario));

    if (respuesta.statusCode == 200) {
      List<dynamic> usuariosJson = json.decode(respuesta.body);

      usuarios.clear();
      
      usuarios.addAll(usuariosJson.map((json) => json['nombre'].toString()).toList());

      currentUser = usuarios[0];
        
    } else {
      throw Exception('Error a la hora de cargar los usuarios');
    }

  }

  Future<void> cambiaColor (Vehiculo vehiculo, String color) async {
    final respuesta = await http.patch(
      Uri.parse('$apiUrlvehiculo/${vehiculo.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'color': color,
      }),
    );

    if (respuesta.statusCode == 200) {
      vehiculo.color = color;
    } else {
      throw Exception('Error al cambiar el color del vehiculo');
    }
  }



  Future<void> pinta(Vehiculo vehiculo, String newcolor) async{
    final response = await http.patch(
      Uri.parse('http://localhost:3000/vehiculo/${vehiculo.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'color': newcolor,
      }),
    );

    if (response.statusCode == 200) {
      vehiculo.color = newcolor;
    } else {
      throw Exception('Failed to update task');
    }
  }
}