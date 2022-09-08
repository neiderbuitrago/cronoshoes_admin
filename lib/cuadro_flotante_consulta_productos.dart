//ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db/categoria.dart';
import 'db/debouncer.dart';
import 'db/marcas_mongo.dart';
import 'db/productosdb.dart';
import 'estados_getx.dart/productos_getx.dart';
import 'funciones_generales/response.dart';
import 'lista_seleccion.dart';
import 'model_data/productos.dart';

Future<dynamic> listaFlotanteConsulta({
  required BuildContext context,
  required String coleccion,
  int? index,
  bool? esProducto = false,
  String? letrasparaBuscar = '',
  final TextEditingController? controladorBuscar,
}) {
  print('letras para buscar: $letrasparaBuscar');
  return showDialog(
      barrierColor: Colors.black.withOpacity(0.2),
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(230, 255, 255, 255),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: ListaSeleccion(
            coleccion: coleccion,
            index: index,
            esProducto: esProducto,
            letrasparaBuscar: letrasparaBuscar,
            controladorBuscar: controladorBuscar,
          ),
        );
      });
}

class ListaSeleccion extends StatefulWidget {
  const ListaSeleccion({
    Key? key,
    required this.coleccion,
    this.index,
    this.esProducto,
    this.letrasparaBuscar,
    this.controladorBuscar,
  }) : super(key: key);

  final String coleccion;
  final int? index;
  final bool? esProducto;
  final String? letrasparaBuscar;
  final TextEditingController? controladorBuscar;

  @override
  State<ListaSeleccion> createState() => _ListaSeleccionState();
}

class _ListaSeleccionState extends State<ListaSeleccion> {
  TextEditingController controladorEncFiltro = TextEditingController();

  EstadoProducto estadoProductos = Get.find<EstadoProducto>();
  String _letrasFiltro = "";
  bool llenarDatoTraido = true;

  filtrarValores() {
    print('teclado abierto ${MediaQuery.of(context).viewInsets.bottom}');

    estadoProductos.marcasFiltradas.clear();

    if (widget.esProducto == true) {
      ProductosDB.getnombre(_letrasFiltro).then((value) {
        if (value != null) {
          value.forEach((element) async {
            final marca = await MarcaDB.getId(element['marcaId']);
            if (marca != null) {
              Map<String, dynamic> producto =
                  Productos.fromMap(element).toMap();
              producto.addAll({"nombreMarca": marca[0]['nombre']});
              estadoProductos.marcasFiltradas.add(producto);
            }
          });
        }
      });
    } else {
      widget.coleccion == 'Marca'
          ? MarcaDB.getParametro(_letrasFiltro).then((value) {
              if (value != null) {
                value.forEach((element) {
                  estadoProductos.marcasFiltradas.add(element);
                });
              }
            })
          : widget.coleccion == "Grupo"
              ? GruposDB.getParametro(_letrasFiltro).then((value) {
                  if (value != null) {
                    value.forEach((element) {
                      estadoProductos.marcasFiltradas.add(element);
                    });
                  }
                })
              : null;
    }
  }

  @override
  initState() {
    super.initState();
    controladorEncFiltro.text = widget.letrasparaBuscar ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
    });
  }

  @override
  Widget build(BuildContext context) {
    var debouncer = Debouncer();
    if (widget.letrasparaBuscar != null && llenarDatoTraido) {
      ///si se trae un dato de una pantalla anterior
      llenarDatoTraido = false;
      _letrasFiltro = widget.letrasparaBuscar ?? '';
    }

    AnchoDePantalla medidas = anchoPantalla(context);

    filtrarValores();
    print("""${medidas.anchoLista}
    ${medidas.alto * 0.6}""");

    return SizedBox(
      width: medidas.anchoLista,
      height: medidas.alto * 0.7,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    const Color.fromARGB(118, 110, 226, 255).withOpacity(0.8),
                  ],
                  transform: const GradientRotation(4 / 80),
                  stops: const [0.6, 0.9]),
            ),
            child: Column(
              children: [
                Text(
                  ' ${widget.coleccion}',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        width: medidas.anchoLista - 100,
                        child: TextField(
                          autofocus: true,
                          controller:
                              widget.controladorBuscar ?? controladorEncFiltro,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'Buscar',
                          ),
                          onChanged: (value) {
                            debouncer.run(() {
                              _letrasFiltro = value;
                              filtrarValores();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          listaMarcaGrupoImpuesto(widget.esProducto ?? false)
        ],
      ),
    );
  }

  //filtro de grupos y marcas
}
