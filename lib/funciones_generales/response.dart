// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class AnchoDePantalla {
  late BuildContext context;
  late double ancho;
  late double alto;
  late double altoteclado;
  late double anchoLista;

  AnchoDePantalla({
    required this.context,
    required this.ancho,
    required this.alto,
    required this.altoteclado,
    required this.anchoLista,
  });
}

anchoPantalla(context) {
  double ancho = MediaQuery.of(context).size.width;
  double alto = MediaQuery.of(context).size.height;
  AnchoDePantalla anchoDePantalla = AnchoDePantalla(
    context: context,
    ancho: ancho,
    alto: alto,
    altoteclado: MediaQuery.of(context).viewInsets.bottom,
    anchoLista: (ancho <= 500)
        ? ancho - 100
        : (ancho > 500 && ancho < 800)
            ? 450
            : (ancho > 800 && ancho < 1200)
                ? 600
                : 750,
  );
  return anchoDePantalla;
}

tamanoIconos(context) {
  double tamano = (anchoPantalla(context).ancho * 0.038);

  return (tamano > 54)
      ? 54.0
      : (tamano < 35)
          ? 35.0
          : tamano;
}

tamanoletraMediano(context) {
  double tamano = (anchoPantalla(context).ancho * 0.017);
  //print(tamano);
  return (tamano > 24.0)
      ? 24.0
      : (tamano < 19.5)
          ? 19.5
          : tamano;
}

tamanoletraPequeno(context) {
  double tamano = (anchoPantalla(context).ancho * 0.01);

  return (tamano > 15.3)
      ? 15.3
      : (tamano < 11.0)
          ? 11.0
          : tamano;
}

altoencabezadoVentas(context) {
  double alto = (anchoPantalla(context).ancho * 0.038) + (125);
  print(alto);
  return (alto > 182)
      ? 182.0
      : (alto < 160.0)
          ? 160.0
          : alto;
}
