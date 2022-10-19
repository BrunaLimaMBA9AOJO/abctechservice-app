import 'dart:async';
import 'package:abctechapp/controller/assist_controller.dart';
import 'package:abctechapp/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomePage extends GetView<AssistController>{
  const HomePage({super.key});

  
  Widget renderAssist(List<Assist> assist){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: assist.length,
      itemBuilder: (
        ((context, index) => 
          ListTile(
            title: Text(assist[index].name),             
            selectedColor: Colors.purple,
            selected: controller.isSelected(index),
            onTap: () => controller.selectAssist(index),
        ))));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Seleção de Serviços")),

      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView ( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
            Row(
              children: const [
                Expanded(
                  child: Padding(padding: EdgeInsets.all(15), 
                  child: Text('Serviços Disponíveis:', textAlign: TextAlign.center, 
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )))
              ],
              ),
          controller.obx((state) => renderAssist(state ?? []),
          onEmpty: const Text('Nenhuma assistência disponível'),
          onError: ((error) => Text(error.toString()))),
          ],
        )),
      ),
      
      floatingActionButton: FloatingActionButton( onPressed: () => controller.finishSelectAssist(), child: const Icon(Icons.done)),
    );
  }
}