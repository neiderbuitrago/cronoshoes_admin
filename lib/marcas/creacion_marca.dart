//ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../estados_getx.dart/marcas_getx.dart';
import 'lista.dart';
import 'widget.dart';

class CreacionMarca extends StatefulWidget {
  const CreacionMarca({
    Key? key,
    // required this.contextProducto,
  }) : super(key: key);
  // final BuildContext contextProducto;

  @override
  _CreacionMarcaState createState() => _CreacionMarcaState();
}

class _CreacionMarcaState extends State<CreacionMarca> {
  final EstadoMarcas estadoMarcas = Get.put(EstadoMarcas());

  final formKey = GlobalKey<FormState>();

  TextField entradaTexto(Function redibujarLista) {
    return textFormFieldGeneral(
      context: context,
      redibujarLista: redibujarLista,
      labelText: 'Marca',
      esMarca: true,
      focusNode: estadoMarcas.focusNode,
    );
  }

  Padding guardar(BuildContext context) {
    return elevatedButtonGuardar(
      redibujarLista: redibujarLista,
      context: context,
      esmarca: true,
      controlador: estadoMarcas.controlador[0],
      focusNode: estadoMarcas.focusNode,
    );
  }

  ListaMarcasGrupos lista() {
    return ListaMarcasGrupos(
      controlador: estadoMarcas.controlador,
      texto: 'la Marca',
      redibujarLista: redibujarLista,
    );
  }

  redibujarLista() {
    setState(
      () {
        lista();
      },
    );
  }

  @override
  void initState() {
    estadoMarcas.focusNode = [FocusNode(), FocusNode()];
    estadoMarcas.controlador = [TextEditingController()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creacion de Marcas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              entradaTexto(redibujarLista),
              guardar(context),
              lista(),
            ],
          ),
        ),
      ),
    );
  }
}
