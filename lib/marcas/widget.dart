// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../db/categoria.dart';
import '../db/debouncer.dart';
import '../db/marcas_mongo.dart';
import '../estados_getx.dart/grupos_getx.dart';
import '../estados_getx.dart/marcas_getx.dart';
import '../funciones_generales/strings.dart';
import '../model_data/marcas.dart';
import '../widget.dart';

textFormFieldGeneral({
  required BuildContext context,
  required Function redibujarLista,
  required String labelText,
  required bool esMarca,
  required List<FocusNode> focusNode,
}) {
  var debouncer = Debouncer();
  FocusScope.of(context).requestFocus(focusNode[0]);
  EstadoGrupos estadoGrupos = Get.put(EstadoGrupos());
  EstadoMarcas estadoMarcas = Get.put(EstadoMarcas());

  campoEnMayusculas(controller: estadoGrupos.controlador[0]);
  campoEnMayusculas(controller: estadoMarcas.controlador[0]);

  return TextField(
    focusNode: focusNode[0],
    textCapitalization: TextCapitalization.characters,
    onEditingComplete: () {
      FocusScope.of(context).requestFocus(focusNode[1]);
    },
    controller:
        (esMarca) ? estadoMarcas.controlador[0] : estadoGrupos.controlador[0],
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        gapPadding: 5,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
      // cancelar el texto
      suffixIcon: IconButton(
        padding: const EdgeInsets.only(right: 10),
        icon: const Icon(Icons.clear),
        onPressed: () {
          (esMarca)
              ? estadoMarcas.nuevoEditar.value = true
              : estadoGrupos.nuevoEditar.value = true;
          (esMarca)
              ? estadoMarcas.controlador[0].text = ''
              : estadoGrupos.controlador[0].text = '';

          redibujarLista();
        },
      ),
    ),
    onChanged: (value) {
      debouncer.run(() {
        redibujarLista();
      });
    },
    onTap: () => redibujarLista(),
  );
}

Padding elevatedButtonGuardar({
  required BuildContext context,
  required Function redibujarLista,
  required bool esmarca,
  required TextEditingController controlador,
  required focusNode,
}) {
  onPressed() async {
    EstadoGrupos estadoGrupos = Get.find<EstadoGrupos>();
    EstadoMarcas estadoMarcas = Get.find<EstadoMarcas>();
    bool nuevoEditar = (esmarca)
        ? estadoMarcas.nuevoEditar.value
        : estadoGrupos.nuevoEditar.value;

    //

    MarcasGrupos marcas = MarcasGrupos(
      id: (nuevoEditar)
          ? ObjectId()
          : (esmarca)
              ? estadoMarcas.marca.id
              : estadoGrupos.grupo.id,
      nombre: controlador.text.trim().toUpperCase(),
    );
    if (esmarca
        ? estadoMarcas.controlador[0].text.isNotEmpty
        : estadoGrupos.controlador[0].text.isNotEmpty) {
      if (nuevoEditar) {
        (esmarca)
            ? await MarcaDB.insertar(marcas).then((value) => redibujarLista)
            : await GruposDB.insertar(marcas).then((value) => redibujarLista);
      } else {
        (esmarca)
            ? await MarcaDB.actualizar(marcas).then((value) => redibujarLista)
            : await GruposDB.actualizar(marcas).then((value) => redibujarLista);
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: (nuevoEditar)
            ? Text(
                '${(!esmarca) ? "Grupo guardado" : "Marca guardada"} ${marcas.nombre} ')
            : Text(
                ' ${(!esmarca) ? "Grupo editado" : "Marca editada"} ${marcas.nombre} '),
      ),
    );

    //linpiar el formulario

    controlador.clear();
    focusNode[0].requestFocus();
    (esmarca)
        ? estadoMarcas.nuevoEditar.value = true
        : estadoGrupos.nuevoEditar.value = true;
    redibujarLista();
  }

  return elevatedButtonGuardar1(
    context: context,
    onPressed: onPressed,
    focusNode: focusNode[1],
  );
}
