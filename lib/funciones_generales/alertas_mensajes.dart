import 'package:flutter/material.dart';

Future<dynamic> informarFlotante({
  required BuildContext context,
  String? titulo,
  required String valor,
  required String texto,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        insetAnimationDuration: const Duration(milliseconds: 700),
        backgroundColor: Colors.white.withOpacity(0.88),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: 350,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 50,
                ),
                textos(titulo ?? 'No se puede guardar'),
                const SizedBox(
                  height: 10,
                ),
                Center(child: textos(texto)),
                textos(valor),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget alertaRedondeada() {
  return const AlertDialog(
    title: Text('Titulo'),
    content: Text('Contenido'),
  );
}

Text textos(String texto) {
  return Text(
    texto,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextButton textButtonReusable(
  VoidCallback onPressed,
  Widget titulo,
) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.blueAccent,
      elevation: 10,
      side: const BorderSide(
        color: Colors.blue,
        width: 0.5,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
    ),
    onPressed: onPressed,
    child: Padding(padding: const EdgeInsets.all(3.0), child: titulo),
  );
}

informarInferior(
    {required String titleText,
    required String messageText,
    required BuildContext context}) {
  final snackBar = SnackBar(
    padding: const EdgeInsets.symmetric(horizontal: 0),
    width: MediaQuery.of(context).size.width * 0.7,
//crear un gradiente de colores

    //  backgroundColor: Colors.white,
    content: Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 9, 226, 255),
            Color.fromARGB(255, 255, 255, 255),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255),
          width: 5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              caritaFeliz(),
              const SizedBox(
                width: 50,
              ),
              Text(
                titleText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // caritaFeliz(),
            ],
          ),
          Text(messageText,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    ),
    elevation: 5,
    behavior: SnackBarBehavior.floating,
    // dismissDirection: DismissDirection.vertical,

    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ),
    //
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Icon caritaFeliz() {
  return const Icon(
    Icons.insert_emoticon_rounded,
    color: Colors.orangeAccent,
    size: 50,
    shadows: [
      Shadow(
        blurRadius: 10,
        color: Colors.black,
        offset: Offset(1, 1),
      ),
    ],
  );
}

scaffoldMessenger({required BuildContext context, required String mensaje}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(mensaje)),
  );
}
