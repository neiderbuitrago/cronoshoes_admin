// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model_data/marcas.dart';

class EstadoGrupos extends GetxController {
  var context;
  var nuevoEditar = true.obs;

  late MarcasGrupos grupo = <MarcasGrupos>{}.obs as MarcasGrupos;
  late List<TextEditingController> controlador =
      <TextEditingController>[TextEditingController()].obs;
  late List<FocusNode> focusNode = <FocusNode>[FocusNode(), FocusNode()];
}
