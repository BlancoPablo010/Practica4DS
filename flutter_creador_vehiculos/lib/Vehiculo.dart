class Vehiculo {
  int? id;
  String? motor;
  String? ruedas;
  String? carroceria;
  String? personalizacion;
  String? usuario;
  String? color;

  @override
  String toString() {
    return 'Tiene $motor, $ruedas, $carroceria y modo motor $personalizacion';
  }

  Vehiculo();
  Vehiculo._({this.id, this.motor, this.ruedas, this.carroceria, this.personalizacion, this.usuario, this.color});
  
  factory Vehiculo.fromJson(Map<String, dynamic> json) {
    return Vehiculo._(
      id: json['id'] as int?,
      motor: json['motor'] as String?,
      ruedas: json['ruedas'] as String?,
      carroceria: json['carroceria'] as String?,
      personalizacion: json['personalizacion'] as String?,
      usuario: json['usuario'] as String?,
      color: json['color'] as String?
    );
  }

  Map<String, dynamic> toJson(){
    return{
      if(id != null)
        'id' : id,
        'motor' : motor,
        'ruedas' : ruedas,
        'carroceria' : carroceria,
        'personalizacion' : personalizacion,
        'usuario' : usuario,
        'color' : color 
    };
  }
}