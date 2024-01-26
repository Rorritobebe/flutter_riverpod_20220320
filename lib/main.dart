import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista RSL',
      home: MyHomePage(),
    );
  }
}

class Actividad {
  String descripcion;
  bool completada;

  Actividad({required this.descripcion, this.completada = false});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Actividad> actividades = [];
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pendientes'),
      ),
      body: ListView.builder(
        itemCount: actividades.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.horizontal,
            background: Container(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete),
                ],
              ),
            ),
            onDismissed: (direction) {
              actividades.removeAt(index);
              setState(() {});
            },
            key: Key(actividades[index].descripcion), 
            child: ListTile(
              title: Text(
                actividades[index].descripcion,
                style: TextStyle(
                  decoration: actividades[index].completada
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.check_box),
                onPressed: () {
                  marcarActividadComoCompletada(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmar Actividad'),
                content: TextField(
                  controller: _textController,
                  decoration: InputDecoration(labelText: 'Nueva actividad'),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                  ),
                  TextButton(
                    child: Text('Confirmar'),
                    onPressed: () {
                      agregarActividad();
                      Navigator.of(context).pop(); 
                    },
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Agregar actividad',
        child: Icon(Icons.add),
      ),
    );
  }

  void agregarActividad() {
    final nuevaActividad = _textController.text;
    if (nuevaActividad.isNotEmpty) {
      actividades.add(Actividad(descripcion: nuevaActividad));
      _textController.clear();
      setState(() {});
    }
  }

  void marcarActividadComoCompletada(int index) {
    setState(() {
      actividades[index].completada = !actividades[index].completada;
    });
  }
}
