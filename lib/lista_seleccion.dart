import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'estados_getx.dart/productos_getx.dart';
import 'model_data/productos.dart';

listaMarcaGrupoImpuesto(bool esProducto) {
  EstadoProducto estadoProducto = Get.find<EstadoProducto>();
  // MarcaDB.getParametro("");

  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: Obx(
          () => ListView.builder(
            itemCount: estadoProducto.marcasFiltradas.length,
            itemBuilder: (context, index) {
              final marca = estadoProducto.marcasFiltradas[index];
              return ListTile(
                hoverColor: const Color(0xFF26C2FF).withOpacity(0.7),
                focusColor: const Color.fromRGBO(179, 114, 172, 1),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.primaries[index].withOpacity(0.8),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                title: (esProducto)
                    ? Text(
                        marca["nombre"],
                        // ' -' +
                        // boxMarcas.getAt(marca.marca)s).nombre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        marca["nombre"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                subtitle: (esProducto)
                    ? Text(
                        marca["codigo"] +
                            '    Existe: ' +
                            (marca["cantidad"]).toString() +
                            '    Marca: ${marca["nombreMarca"]} ',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      )
                    : null,
                trailing: (esProducto)

                    //colocar los puntos de miles y decimales

                    ? Text(
                        '\$'
                        '${((marca["precioVenta1"]).toString())}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))
                    : null,
                onTap: () {
                  (esProducto)
                      ? Navigator.of(context).pop(Productos.fromMap(marca))
                      : Navigator.of(context).pop(marca);
                },
              );
            },
          ),
        ),
      ),
    ),
  );
}
