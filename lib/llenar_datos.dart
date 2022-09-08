// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'db/productosdb.dart';
import 'estados_getx.dart/productos_getx.dart';
import 'limpiar_form_productos.dart';
import 'model_data/productos.dart';

llenarDatos({
  required String codigo,
}) async {
  ProductosDB.getcodigo(codigo).then(
    (value) {
      if (value != null) {
        llenarDatosTraidos(Productos.fromMap(value[0]));

        //consultar si el codigo existe en multicodigo
      } else {
        limpiarTextos(index: 1);
      }
    },
  );
}

Set<dynamic> llenarDatosTraidos(
  Productos producto,
) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  var controladores = estadoProducto.controladores;

  return {
    estadoProducto.productoConsultado = producto,
    estadoProducto.nuevoEditar.value = false,
    estadoProducto.controladores[0].text = producto.codigo,
    controladores[1].text = producto.nombre,
  };
}
