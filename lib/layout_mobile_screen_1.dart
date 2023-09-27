import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_data.dart';
import 'layout_mobile_screen_2.dart';

class LayoutMobileScreen1 extends StatefulWidget {

  final String seccio;

  const LayoutMobileScreen1({Key? key, required this.seccio}) : super(key: key);
  @override
  State<LayoutMobileScreen1> createState() => _StateLayoutMobileScreen1();
}

class _StateLayoutMobileScreen1 extends State<LayoutMobileScreen1> {

  _StateLayoutMobileScreen1();

  void _navigateTo (BuildContext context, String value, int index) {
     Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LayoutMobileScreen2(seccio: value, index: index)));
  }

  @override
  Widget build(BuildContext context) {

    Widget _setBody(BuildContext context) {
      // Referència a l’objecte que gestiona les dades de l’aplicació
      AppData _appData = Provider.of<AppData>(context);

      if (!_appData.dataReady(widget.seccio)) {
        // Si no tenim les dades, carregar-les i mostrar un 'loading'
        _appData.load(widget.seccio);
        return const Center(child: CircularProgressIndicator());
      } else {
        // Dades disponibles, construir automàticament la llista
        var data = _appData.getData(widget.seccio);
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(data[index]['nom']),
              leading: Image.asset(
                'assets/images/${data[index]["imatge"]}',
                height: 50.0,
                width: 50.0,
                fit: BoxFit.contain,
              ),
              onTap: () => _navigateTo(context, widget.seccio, index),
            );
          }
        );
      }
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.seccio),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _setBody(context)
    );
  }
}
