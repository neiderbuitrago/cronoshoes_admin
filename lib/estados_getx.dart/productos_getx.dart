// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../funciones_generales/numeros.dart';
import '../model_data/productos.dart';

class EstadoProducto extends GetxController {
  var nombreComboSeleccionado = ''.obs;
  var seleccionTipoProducto = 'Activo'.obs;
  List<String> campos = [
    "Codigo",
    "Nombre",
    "URL",
    "Descripcion",
    "Marca",
    "Modelo",
    "Categoria",
    "Me gusta",
    "Color",
    "Tallas",
    "Precio Costo",
    "PrecioVenta",
    "Cantidad"
  ];

  var marcasFiltradas = [].obs;
  List<TextEditingController> controladores = <TextEditingController>[].obs;

  List<FocusNode> focusNode = <FocusNode>[].obs;
  List<Widget> listadeTexfromFieldPrincipal = <Widget>[].obs;

  late Productos productoConsultado = {}.obs as Productos;
  var nuevoEditar = true.obs;

  datosproducto() {
    return Productos(
      id: ObjectId(),
      codigo: controladores[0].text,
      nombre: controladores[1].text,
      url: controladores[2].text,
      descripcion: controladores[3].text,
      marca: controladores[4].text,
      modelo: controladores[5].text,
      grupo: controladores[6].text,
      megusta: numeroDecimal(controladores[7].text),
      color: controladores[8].text,
      tallas: controladores[9].text,
      precioCosto: numeroDecimal(controladores[10].text),
      precioVenta: numeroDecimal(controladores[11].text),
      cantidad: numeroDecimal(controladores[12].text),
      fechapublicacion: DateTime.now(),
    );
  }
}
