import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model_data/marcas.dart';

class EstadoMarcas extends GetxController {
  var nuevoEditar = true.obs;

  late MarcasGrupos marca = <MarcasGrupos>{}.obs as MarcasGrupos;
  late List<TextEditingController> controlador = <TextEditingController>[
    TextEditingController()
  ];
  late List<FocusNode> focusNode = <FocusNode>[FocusNode(), FocusNode()];
}
