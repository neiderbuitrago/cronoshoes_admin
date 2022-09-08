// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:cronoshoes_admin/model_data/productos.dart';
import 'package:cronoshoes_admin/text_form_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'db/productosdb.dart';
import 'estados_getx.dart/productos_getx.dart';

import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EstadoProducto estadoProducto = Get.put(EstadoProducto());

  // final storageRef = FirebaseStorage.instance.ref();
  //final nameImage = const ;
  final ImagePicker _picker = ImagePicker();

  File? imagen = null;
  @override
  void initState() {
    super.initState();
  }

  //
  asignarImagen(pickedFile) async {
    setState(() {
      imagen = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    EstadoProducto estado = Get.find<EstadoProducto>();
    if (estadoProducto.controladores.isEmpty) {
      estadoProducto.controladores = [
        for (var i = 0; i < (estadoProducto.campos.length); i++)
          TextEditingController()
      ];

      estadoProducto.focusNode = [
        for (int i = 0; i < (estadoProducto.campos.length + 1); i++) FocusNode()
      ];
      estadoProducto.focusNode = [
        for (int i = 0; i < (estadoProducto.campos.length + 1); i++) FocusNode()
      ];
      for (var i = 0; i < estadoProducto.campos.length; i + i++) {
        estadoProducto.listadeTexfromFieldPrincipal.add(
          TextFormFieldProducto(index: i, asignarImagen: asignarImagen),
        );
      }
    }
    return FutureBuilder(
      future: ProductosDB.getnombre("a"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () async {
                        await guardarImagen();
                      },
                      icon: const Icon(
                        Icons.save_as_rounded,
                        size: 35,
                        color: Colors.white,
                      ))
                ],
                title: const Text("Productos"),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final XFile? pickedFile = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedFile != null) {
                          estadoProducto.controladores[2].text =
                              pickedFile.path;
                          asignarImagen(pickedFile);
                        }
                      },
                      child: Expanded(
                        child: imagen == null
                            ? Image.asset(
                                "assets/imagenes/producto-sin-imagen.png")
                            : Image.file(imagen!),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        children: estadoProducto.listadeTexfromFieldPrincipal,
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<void> guardarImagen() async {
    ProductosDB.insertar(estadoProducto.datosproducto());

    var ruta = "${const Uuid().v1()}.jpg";
    final storageReference =
        FirebaseStorage.instance.ref("imagenes_grandes").child(ruta);
    final uploadTask = storageReference.putFile(imagen!);

    final StreamSubscription streamSubscription =
        uploadTask.snapshotEvents.listen((event) {
      print('EVENT ${event.state}');
    });
    await uploadTask.whenComplete(() {
      print('completado');

      ProductosDB.insertar(estadoProducto.datosproducto());
    });
    streamSubscription.cancel();
  }
}
