// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../estados_getx.dart/grupos_getx.dart';
import '../marcas/lista.dart';
import '../marcas/widget.dart';

class CreacionGrupo extends StatefulWidget {
  const CreacionGrupo({Key? key}) : super(key: key);

  @override
  _CreacionGrupoState createState() => _CreacionGrupoState();
}

class _CreacionGrupoState extends State<CreacionGrupo> {
  final EstadoGrupos estadoGrupos = Get.find<EstadoGrupos>();

  TextField entradaTexto(Function redibujarLista) {
    return textFormFieldGeneral(
      context: estadoGrupos.context,
      redibujarLista: redibujarLista,
      labelText: 'Grupo',
      esMarca: false,
      focusNode: estadoGrupos.focusNode,
    );
  }

  Padding guardar() {
    return elevatedButtonGuardar(
      context: estadoGrupos.context,
      redibujarLista: redibujarLista,
      esmarca: false,
      controlador: estadoGrupos.controlador[0],
      focusNode: estadoGrupos.focusNode,
    );
  }

  ListaMarcasGrupos lista() {
    return ListaMarcasGrupos(
      controlador: estadoGrupos.controlador,
      texto: 'el Grupo',
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
    estadoGrupos.focusNode = [FocusNode(), FocusNode()];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    estadoGrupos.context = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creacion de Grupos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              entradaTexto(redibujarLista),
              guardar(),
              lista(),
            ],
          ),
        ),
      ),
    );
  }
}
