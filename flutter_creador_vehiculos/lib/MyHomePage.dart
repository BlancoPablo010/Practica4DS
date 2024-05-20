import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ConstructorVehiculo.dart';
import 'ConstructorCamion.dart';
import 'ConstructorAutomovil.dart';
import 'ConstructorMoto.dart';
import 'EstrategiaPersonalizacion.dart';
import 'EstrategiaEco.dart';
import 'EstrategiaDeportiva.dart';
import 'Director.dart';
import 'Vehiculo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> isSelected = [true, false];
  String vehicleType = 'moto';

  ConstructorVehiculo constructorCamion = ConstructorCamion();
  ConstructorVehiculo constructorAutomovil = ConstructorAutomovil();
  ConstructorVehiculo constructorMoto = ConstructorMoto();

  EstrategiaPersonalizacion estrategiaEco = EstrategiaEco();
  EstrategiaPersonalizacion estrategiaDeportiva = EstrategiaDeportiva();

  final TextEditingController _controller = TextEditingController();

  late Director director;


  late String currentUser = ''; // Usuario actual
  late List<String>usuarios = []; // Lista de usuarios
  late List<Vehiculo>vehiculos = []; // Lista de vehículos

  @override
  void initState() {
    director = Director(constructorAutomovil, estrategiaEco);

    _cargarUsuarios();
    
    super.initState();
    
  }

  void _cargarUsuarios() async {
    try {
      await director.usuariosFromJson();
      
      setState(() {
        usuarios = director.getUsuarios();
        currentUser = usuarios.isNotEmpty ? usuarios[1] : '';
        if(usuarios.isNotEmpty) {
          director.setCurrentUser(currentUser);
          _cargarDatosUsuario();
        }
      });
    } catch (e) {
      throw Exception("Error cargando usuarios: $e");
    }
  }
  
  void _cargarDatosUsuario() async {
    try {
      await director.cargarVehiculos();
      setState(() {
        vehiculos = director.getVehiculos();
      });
    } catch (e) {
      throw Exception("Error cargando vehículos: $e");
    }
  }
  
  void _agregarVehiculo(Vehiculo vehiculo) async {
    try {
      await director.agregar(vehiculo);
      setState(() {
        vehiculos = director.getVehiculos();
      });
    } catch (e) {
      throw Exception("Error agregando vehículo: $e");
    }
  }
  
  _eliminarVehiculo(Vehiculo vehiculo) async {
    try {
      await director.eliminar(vehiculo);
      setState(() {
        vehiculos = director.getVehiculos();
      });
    } catch (e) {
      throw Exception("Error eliminando vehículo: $e");
    }
  }

  _pintaVehiculo(Vehiculo vehiculo, String color) async{
    try {
      await director.pinta(vehiculo, color);
      setState(() {
        vehiculos = director.getVehiculos();
      });
    } catch (e) {
      throw Exception("Error pintando vehículo: $e");
    }
  }
  
  // Método para cambiar de usuario
  void changeUser(String newUser) {
    setState(() {
      currentUser = newUser;
      director.setCurrentUser(currentUser);
      _cargarDatosUsuario();
    });
  }

  _construyeMoto(){
    setState(() {
      vehicleType = 'Moto';
      director.setConstructor(constructorMoto);
      director.construirVehiculo();
      _agregarVehiculo(director.constructor.vehiculo!);
    });
  }

  _construyeCoche(){
    setState(() {
      vehicleType = 'Coche';
      director.setConstructor(constructorAutomovil);
      director.construirVehiculo();
      _agregarVehiculo(director.constructor.vehiculo!);
    });
  }

  _construyeCamion(){
    setState(() {
      vehicleType = 'Camión';
      director.setConstructor(constructorCamion);
      director.construirVehiculo();
      _agregarVehiculo(director.constructor.vehiculo!);
    });
  }
  
  _cambiaEstrategia(int index){
    setState(() {
      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
        isSelected[buttonIndex] = buttonIndex == index;
        director.setEstrategia(index == 0 ? estrategiaEco : estrategiaDeportiva);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          DropdownButton<String>(
            value: currentUser,
            icon: const Icon(Icons.person),
            underline: Container(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                changeUser(newValue);
              }
            },
            items: usuarios
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Selecciona el tipo de vehículo:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ToggleButtons(
                isSelected: isSelected,
                onPressed: (int index) {
                  _cambiaEstrategia( index);
                },
                children: const <Widget>[
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.eco, size: 50),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.sports_motorsports, size: 50),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ElevatedButton(
                  onPressed: () {
                    _construyeMoto();
                  },
                  child: const Text('Construye una moto'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _construyeCoche();
                  },
                  child: const Text('Construye un automóvil'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _construyeCamion();
                  },
                  child: const Text('Construye un camión'),
                ),
              ]),
              const SizedBox(
                height: 50.0,
              ),
              if (director.constructor.vehiculo != null)
                Text(
                  vehicleType,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(
                height: 20.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Vehículos construidos:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: vehiculos.length,
                  itemBuilder: (BuildContext context, int index) {
                    final vehiculo = vehiculos[index];
                    
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(vehiculo.toString()),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Introduce el color'),
                                        content: TextField(
                                          controller: _controller,
                                          decoration: const InputDecoration(
                                            hintText: 'Color',
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              _pintaVehiculo(vehiculo, _controller.text);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Aceptar'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text('Pintar'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  _eliminarVehiculo(vehiculo);
                                },
                                child: const Text('Eliminar'),
                              ),
                            ]
                          )
                        ]
                      )
                    );
                  },
                  separatorBuilder: (_,__) => const Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
