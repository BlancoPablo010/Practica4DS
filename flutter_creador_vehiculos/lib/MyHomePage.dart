import 'package:flutter/material.dart';
import 'ConstructorVehiculo.dart';
import 'ConstructorCamion.dart';
import 'ConstructorAutomovil.dart';
import 'ConstructorMoto.dart';
import 'EstrategiaPersonalizacion.dart';
import 'EstrategiaEco.dart';
import 'EstrategiaDeportiva.dart';
import 'Director.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
  
  late Director director;

  late final ScrollController _controller;

  @override
  void initState() {
    director = Director(constructorAutomovil, estrategiaEco);

    _controller = ScrollController();
    //director.setEstrategia(estrategiaEco);
    super.initState();
  }


  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < isSelected.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                        director.setEstrategia(index == 0 ? estrategiaEco : estrategiaDeportiva);
                      } else {
                        isSelected[buttonIndex] = false;
                        director.setEstrategia(index == 0 ? estrategiaEco : estrategiaDeportiva);
                      }
                    }
                  });
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
                    setState(() {
                      vehicleType = 'Moto';
                      director.setConstructor(constructorMoto);
                      director.construirVehiculo();
                    });
                  },
                  child: const Text('Construye una moto'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      vehicleType = 'Coche';
                      director.setConstructor(constructorAutomovil);
                      director.construirVehiculo();
                    });
                  },
                  child: const Text('Construye un automóvil'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      vehicleType = 'Camión';
                      director.setConstructor(constructorCamion);
                      director.construirVehiculo();
                    });
                  },
                  child: const Text('Construye un camión'),
                ),
              ]),
              const SizedBox(
                height: 50.0,
              ),
              if (director.constructor.vehiculo !=  null) 
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
              if (director.constructor.vehiculo != null) 
                Text(
                  '${director.constructor.vehiculo}',
                  
                
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              const SizedBox (
                height: 20.0,
              ),
              const Text(
                'Vehículos construidos:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomScrollView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: _controller,
                slivers: <Widget>[
                  SliverList.separated(
                      itemCount: director.getVehiculos().length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(director.getVehiculos()[index].toString()),
                        );
                      },
                      separatorBuilder: (_,__) => const Divider(
                        indent: 20,
                        endIndent: 20,
                        thickness: 2,
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}