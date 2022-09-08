import 'package:get/get.dart';

import 'estados_getx.dart/productos_getx.dart';

void limpiarTextos({required int index}) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();

  limpiar() {
    estadoProducto.seleccionTipoProducto.value = 'Activo';
    estadoProducto.nuevoEditar.value = true;
  }

  if (index == 0) {
    for (var i = 0; i < estadoProducto.controladores.length; i++) {
      if (i != 2 && i != 3 && i != 4 && i != 17) {
        estadoProducto.controladores[i].clear();
      }
      limpiar();
    }
  } else {
    for (var i = 1; i < estadoProducto.controladores.length; i++) {
      if (i != 2 && i != 3 && i != 4 && i != 17) {
        estadoProducto.controladores[i].clear();
      }
    }

    limpiar();

    estadoProducto.nombreComboSeleccionado.value = '';
  }
}
