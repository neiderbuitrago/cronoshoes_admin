// ignore_for_file: avoid_print

import 'package:cronoshoes_admin/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import 'cuadro_flotante_consulta_productos.dart';
import 'estados_getx.dart/productos_getx.dart';
import 'llenar_datos.dart';

//CONSTRUIR UN FUTURE BUILDER PARA LA CONSULTA DE PRODUCTOS

class TextFormFieldProducto extends StatefulWidget {
  @override
  const TextFormFieldProducto({
    Key? key,
    required this.index,
    required this.asignarImagen,
  }) : super(key: key);

  final int index;
  final Function asignarImagen;

  @override
  State<TextFormFieldProducto> createState() => _TextFormFieldProductoState();
}

class _TextFormFieldProductoState extends State<TextFormFieldProducto> {
  EstadoProducto estadoProducto = Get.find();
  late String _texto = '';
  final ImagePicker _picker = ImagePicker();

  bool comprovarSiHayValores(
    int cuantosCamposExaminara,
    List listaControles,
  ) {
    bool devolver = true;
    for (var i = 0; i < cuantosCamposExaminara; i++) {
      if (listaControles[i].text.isEmpty) {
        devolver = false;
        break;
      }
    }
    return devolver;
  }

  @override
  initState() {
    super.initState();
    nuevoCodigostring().then((value) {
      setState(() {
        _texto = value.toString();
      });
    });
  }

  actualizar() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double anchoPantalla = MediaQuery.of(context).size.width;

    final ancho = (anchoPantalla < 600) ? anchoPantalla : anchoPantalla * 0.5;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SizedBox(
            width: ancho - 12,
            child: Row(
              children: [
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(189, 233, 231, 231),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  width: (widget.index == 1 ||
                          widget.index == 6 ||
                          widget.index > 21 && widget.index <= 28)
                      ? ancho - 71
                      : ancho - 12,
                  child: texfieldFormFieldProductos(context),
                ),
                if (widget.index == 1)
                  IconButton(
                    icon: const Icon(
                      Icons.search_outlined,
                      size: 40,
                    ),
                    onPressed: () {
                      listaFlotanteConsulta(
                        context: context,
                        coleccion: "Productos",
                        esProducto: true,
                        letrasparaBuscar: estadoProducto.controladores[1].text,
                      ).then(
                        (value) {
                          if (value != null) {
                            //   estadoProducto.controladores[1].text = value.nombre;
                            llenarDatos(
                              codigo: value.codigo,
                            );
                          }
                        },
                      );
                    },
                  ),
              ],
            )));
  }

  TextFormField texfieldFormFieldProductos(BuildContext context) {
    var textFormField2 = TextFormField(
      maxLines: null,
      autocorrect: true,
      onTap: (widget.index == 0)
          ? () async {
              nuevoCodigostring().then((value) {
                setState(() {
                  _texto = value.toString();
                });
              });
            }
          : (widget.index == 2)
              ? () async {
                  // seleccionar la imagen desde la galeria
                  final XFile? pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    estadoProducto.controladores[2].text = pickedFile.path;
                    widget.asignarImagen(pickedFile);
                  }
                }
              : null,
      focusNode: estadoProducto.focusNode[widget.index],
      keyboardType:
          (widget.index >= 5 && widget.index != 21 && widget.index != 17)
              ? TextInputType.number
              : TextInputType.text,
      inputFormatters:
          (widget.index >= 5 && widget.index != 21 && widget.index != 17)
              ? [FilteringTextInputFormatter.allow(RegExp('[0-9-.]'))]
              : [],
      onEditingComplete: () {},
      controller: estadoProducto.controladores[widget.index],
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 111, 40, 226), width: 1),
          // Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: Colors.blueAccent,
              width: 2.0,
            )),
        labelText: estadoProducto.campos[widget.index],
        hintText: (widget.index == 0) ? "Consecutivo: $_texto" : "",
        hintStyle: const TextStyle(
            fontSize: 15, color: Color.fromARGB(255, 122, 124, 125)),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 117, 115, 115),
          fontSize: 20,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      ),
      scrollPadding: const EdgeInsets.all(30),
    );
    var textFormField = textFormField2;
    return textFormField;
  }

//boton
}
