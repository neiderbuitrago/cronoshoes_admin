import 'package:mongo_dart/mongo_dart.dart';

class MarcasGrupos {
  final ObjectId id;
  final String nombre;
  MarcasGrupos({
    required this.id,
    required this.nombre,
  });
  Map<String, dynamic> toMap() => {
        'id': id,
        'nombre': nombre,
      };
  static MarcasGrupos fromMap(Map<String, dynamic> map) => MarcasGrupos(
        id: map['id'],
        nombre: map['nombre'],
      );
}
