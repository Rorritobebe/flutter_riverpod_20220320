import 'package:flutter/material.dart';

final List<int> _items = List<int>.generate(10, (int index) => index);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xff6750a4),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool shadowColor = false;
  double? scrolledUnderElevation;
  bool switchValue = false;
  double sliderValue = 0.0;
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RODRIGO SANTANA'),
        scrolledUnderElevation: scrolledUnderElevation,
        shadowColor: shadowColor ? Theme.of(context).colorScheme.shadow : null,
      ),
      body: buildGridView(),
      bottomNavigationBar: buildBottomAppBar(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildGridView() {
    return GridView.builder(
      itemCount: _items.length,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return buildIntroText();
        }
        return buildGridItem(index);
      },
    );
  }

  Widget buildIntroText() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Desplázate para ver la barra de aplicación en acción.',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildGridItem(int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: _items[index].isOdd ? oddItemColor : evenItemColor,
      ),
      child: Text('Item $index'),
    );
  }

  Widget buildBottomAppBar() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: OverflowBar(
          overflowAlignment: OverflowBarAlignment.center,
          alignment: MainAxisAlignment.center,
          overflowSpacing: 5.0,
          children: buildBottomAppBarChildren(),
        ),
      ),
    );
  }

  List<Widget> buildBottomAppBarChildren() {
    return [
      buildElevatedButton(),
      const SizedBox(width: 5),
      buildScrolledUnderElevationButton(),
      const SizedBox(width: 5),
      buildSwitch(),
      const SizedBox(width: 5),
      buildSlider(),
      const SizedBox(width: 5),
    ];
  }

  Widget buildElevatedButton() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          shadowColor = !shadowColor;
        });
      },
      icon: Icon(
        shadowColor ? Icons.visibility_off : Icons.visibility,
      ),
      label: const Text('Color de sombra'),
    );
  }

  Widget buildScrolledUnderElevationButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          scrolledUnderElevation = scrolledUnderElevation == null
              ? 4.0
              : scrolledUnderElevation! + 1.0;
        });
      },
      child: Text(
        'Scrolled Under Elevation: ${scrolledUnderElevation ?? 'predeterminado'}',
      ),
    );
  }

  Widget buildSwitch() {
    return Switch(
      value: switchValue,
      onChanged: (value) {
        setState(() {
          switchValue = value;
        });
      },
    );
  }

  Widget buildSlider() {
    return Slider(
      value: sliderValue,
      onChanged: (value) {
        setState(() {
          sliderValue = value;
        });
      },
      min: 0.0,
      max: 100.0,
      divisions: 10,
      label: 'Valor del deslizador: $sliderValue',
    );
  }
  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('¡Acción del botón flotante!'),
            action: SnackBarAction(
              label: 'Deshacer',
              onPressed: () {
                // Lógica para deshacer la acción
              },
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
