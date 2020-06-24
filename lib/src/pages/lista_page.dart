import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:starwars/src/pages/detalle_page.dart';
import 'package:starwars/src/providers/swapi_providers.dart';

class ListaPage extends StatefulWidget {
  final String tipoPagina;

  const ListaPage({this.tipoPagina});

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  List<dynamic> _listaItems = [];
  ScrollController _scrollController = new ScrollController();
  int _pagina = 1;
  bool hayDatos;

  final _listaIconos = {
    'species': MdiIcons.spaceInvaders,
    'starships': MdiIcons.rocketLaunch,
    'people': Icons.account_circle,
    'planets': MdiIcons.earth
  };

  @override
  void initState() {
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _pagina++;
        setState(() {});
      }
    }); 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetch(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            controller: _scrollController,
            itemCount: _listaItems.length+1,
            itemBuilder: (context,index){
              if(index==_listaItems.length){
                if(hayDatos)
                  return _progressIndicator();
                else
                  return Center(child: Text('No hay más datos'));
              }else{
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(_listaIconos[widget.tipoPagina]),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(snapshot.data[index]['name']),
                      subtitle: Text(_cargarSubtitulo(snapshot.data[index])),
                      onTap: ()=>_navegarDetalle(context,snapshot.data[index]['url']),
                    ),
                    Divider()
                  ],
                );
              }    
            },
          );
        }else{
          return _progressIndicator();
        }
      },
    );
  }

  void _navegarDetalle(BuildContext context,String url ){
      url = url.substring(0,url.length-1);
      var id = url.substring(url.lastIndexOf('/')+1);
      final route = MaterialPageRoute(
        builder: (context) => DetallePage(tipoPagina: widget.tipoPagina,id:int.parse(id))
      );
      Navigator.push(context,route);

  }

  String _cargarSubtitulo(dynamic data){
    switch (widget.tipoPagina) {
      case 'species':
        return 'Clasificación: ${data['classification']}';
        break;
      case 'starships':
        return 'Modelo: ${data['model']}';
        break;
      case 'people':
        return 'Altura: ${data['height']} cm.';
        break;
      default:
        return 'Terreno: ${data['terrain']}';
        break;
    }
  }

  Future<List<dynamic>> fetch() async{
    var provider = new SwapiProvider();
    var response = await provider.getData(widget.tipoPagina,_pagina);
    if(response['results']!=null){
      for(var item in response['results']){
      _listaItems.add(item);
      }
    }
    hayDatos = response['next']!=null;
    return _listaItems; 
  }

  Widget _progressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEC0512)),
      ),
    );
  }
  
}