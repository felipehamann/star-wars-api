import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:starwars/src/providers/swapi_providers.dart';

class DetallePage extends StatelessWidget {
  final String tipoPagina;
  final int id;

  const DetallePage({Key key, this.tipoPagina, this.id}) : super(key: key);


  static const Map<String,dynamic> _listaDatos = {
    'species': {'icono':MdiIcons.spaceInvaders,'datos':['name','classification','designation','average_height','average_lifespan'] },
    'starships': {'icono':MdiIcons.rocketLaunch,'datos':['name','model','manufacter','passengers']},
    'people': {'icono':MdiIcons.accountCircle,'datos':['name','height','mass','birth_year']},
    'planets': {'icono':MdiIcons.earth,'datos':['name','rotation_period','climate','terrain','gravity']}
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Star Wars API: Detalle de Item'),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: fetch(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              //no hay data
              return _progressIndicator();
            }else{
              //ya llego data
              return Card(
                elevation: 1.0,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(_listaDatos[tipoPagina]['icono'], color: Color(0xFFEC0512),),
                        title: Text(snapshot.data['name'],style: TextStyle(fontSize:20,fontWeight:FontWeight.bold,),),
                        subtitle: Text(tipoPagina),
                      ),
                      Divider(thickness: 2.0,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _listaDatos[tipoPagina]['datos'].length,
                          itemBuilder: (context,index){
                            return Column(
                              children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(_listaDatos[tipoPagina]['datos'][index]+': ',style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(snapshot.data[_listaDatos[tipoPagina]['datos'][index]]!=null?snapshot.data[_listaDatos[tipoPagina]['datos'][index]]:'- no data -')
                                    ],
                                  ),
                                  Divider()
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                            child: Text('Volver'),
                            color: Color(0xFFFFE300),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                        )
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),

      ),
    );
  }

  Future<LinkedHashMap<String,dynamic>> fetch() async{
    var provider = new SwapiProvider();
    return await provider.getDataDetalle(tipoPagina,id);

  }

  Widget _progressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEC0512)),
      ),
    );
  } 


}
