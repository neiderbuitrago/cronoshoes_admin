// ignore_for_file: avoid_print
import 'package:mongo_dart/mongo_dart.dart';
import '../model_data/productos.dart';
import '../utilidades.dart';

class ProductosDB {
  static var db, coleccion;

  static Future<void> conectar() async {
    db = await Db.create(url);
    await db.open();
    coleccion = db.collection('productos');
  }

  //consultar por silaba contenida en el nombre
  static Future getnombre(String letras) async {
    try {
      var datos = await coleccion
          .find(where
              .match("nombre", letras, caseInsensitive: true)
              .sortBy("nombre", descending: false))
          .toList();
      print(datos);
      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getcodigoAll() async {
    try {
      var datos = await coleccion
          .find(where
              .match("nombre", "")
              .fields(['codigo']).sortBy('codigo', descending: false))
          .toList();
      return datos;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  static Future getcodigo(String letras) async {
    try {
      List datos = await coleccion
          .find(where.eq("codigo", letras.toUpperCase()))
          .toList();
      if (datos.isEmpty) {
        return null;
      } else {
        return datos;
      }
    } catch (e) {
      print("error al consultar codigo de barras $e");
      return Future.value();
    }
  }

  static Future insertar(Productos datos) async {
    // if (!await existeNombre(datos)) {
    try {
      var value = await coleccion.insertAll([datos.toMap()]);
      print("{El producto se guardado correctamente  $value}");
      return true;
    } catch (e) {
      print(e);
    }
    // } else {
    //   return false;
    // }
  }

  static Future<bool> existeNombre(Productos nombre) async {
    try {
      List existe = await coleccion
          .find(where.eq("nombre", nombre.nombre).or(where
              .eq("nombre", nombre.nombre.toUpperCase())
              .or(where.eq("codigo", nombre.codigo))
              .or(where.eq("codigo", nombre.codigo.toUpperCase()))))
          .toList();
      bool resultado = (existe.isEmpty)
          ? false
          : (existe[0]["_id"] == nombre.id)
              ? false
              : true;

      print("producto existe $resultado");
      return resultado;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> existeElCodigo(
    String codigo,
  ) async {
    try {
      List existe = await coleccion
          .find(where
              .eq("codigo", codigo)
              .or(where.eq("codigo", codigo.toUpperCase())))
          .toList();
      return (existe.isEmpty);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
