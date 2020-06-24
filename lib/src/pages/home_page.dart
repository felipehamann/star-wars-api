import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:starwars/src/pages/lista_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _listaTabs = [
    {'texto':'Especies','icono':MdiIcons.spaceInvaders},
    {'texto':'naves','icono':MdiIcons.rocketLaunch},
    {'texto':'Personajes','icono':Icons.account_circle},
    {'texto':'Planetas','icono':MdiIcons.earth},
  ];

  final _listaPaginas = ['species','starships','people','planets'];

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: DefaultTabController(
         length: _listaTabs.length,
         child: Scaffold(
           appBar: AppBar(
             title: Text('Star Wars API'),
             bottom: TabBar(
               isScrollable: true,
               tabs: _cargarTabs(),
             ),
           ),
           body: TabBarView(
             children: _listaPaginas.map((pagina){
               return ListaPage(tipoPagina: pagina);
             }).toList(),
           )
          )
        ),
      );
  }

  List<Tab> _cargarTabs(){
    return _listaTabs.map((tab){
      return Tab(
        icon: Icon(tab['icono']),
        text: tab['texto'],
      );
    }).toList();
  }
}