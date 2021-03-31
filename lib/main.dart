import 'package:flutter/material.dart';
import 'package:flutter_deber/models/reqres_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Contacto());
  }
}

//Peticion http
Future<ReqResRespuesta> getUsuarios() async {
  final resp = await http.get('https://reqres.in/api/users');
  return reqResRespuestaFromJson(resp.body);
}

class Contacto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FUTURE BUILDER"),
        ),
        body: FutureBuilder(
            future: getUsuarios(),
            builder: (BuildContext contex, AsyncSnapshot<ReqResRespuesta> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return _ListaUsuarios(snapshot.data.data);
              }
            }));
  }
}

class _ListaUsuarios extends StatelessWidget {
  final List<Usuario> usuarios;

  _ListaUsuarios(this.usuarios);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: Usuario.length,
      itemBuilder: (BuildContext context, int i) {
               
        final Usuario = usuarios(i);

        return ListTile(
          title: Text('${usuario.firstName} ${usuario.lasName }'),
          subtitle: Text(Usuario.email),
          trailing: Image.network(usuario.avatar),
        )
      }
    );
  }
}
