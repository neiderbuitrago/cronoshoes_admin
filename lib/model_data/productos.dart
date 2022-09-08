import 'package:mongo_dart/mongo_dart.dart';

class Productos {
  final ObjectId id;
  final String codigo;
  final String nombre;
  final String url;
  final String descripcion;
  final DateTime fechapublicacion;
  final String marca;
  final String modelo;
  final String grupo;
  final double megusta;
  final String color;
  final String tallas;
  final double precioCosto;
  final double precioVenta;
  final double cantidad;
  const Productos(
      {required this.id,
      required this.codigo,
      required this.nombre,
      required this.url,
      required this.descripcion,
      required this.fechapublicacion,
      required this.marca,
      required this.modelo,
      required this.grupo,
      this.megusta = 0,
      required this.color,
      required this.tallas,
      this.precioCosto = 0,
      this.precioVenta = 0,
      this.cantidad = 0});
  Map<String, dynamic> toMap() => {
        'id': id,
        'codigo': codigo,
        'nombre': nombre,
        'url': url,
        'descripcion': descripcion,
        'fechapublicacion': fechapublicacion,
        'marca': marca,
        'modelo': modelo,
        'grupo': grupo,
        'megusta': megusta,
        'color': color,
        'tallas': tallas,
        'precioCosto': precioCosto,
        'precioVenta': precioVenta,
        'cantidad': cantidad,
      };
  static Productos fromMap(Map<String, dynamic> map) => Productos(
        id: map['id'],
        codigo: map['codigo'],
        nombre: map['nombre'],
        url: map['url'],
        descripcion: map['descripcion'],
        fechapublicacion: map['fechapublicacion'],
        marca: map['marca'],
        modelo: map['modelo'],
        grupo: map['grupo'],
        megusta: map['megusta'],
        color: map['color'],
        tallas: map['tallas'],
        precioCosto: map['precioCosto'],
        precioVenta: map['precioVenta'],
        cantidad: map['cantidad'],
      );
}
