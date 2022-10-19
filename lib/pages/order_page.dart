import 'package:abctechapp/controller/order_controller.dart';
import 'package:abctechapp/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);

  Widget renderAssists(List<Assist> assists) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: assists.length,
        itemBuilder: (context, index) =>
            ListTile(title: Text(assists[index].name)));
  }

  @override
  Widget buildForm(BuildContext context) {
    return SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: const [
                      Expanded(
                          child: Text(
                        '1 - Informe o código do prestador',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ))
                    ]),
                    TextFormField(
                      controller: controller.operatorIdController,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: "Insira apenas dígitos"),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value != null && value.isEmpty){
                          return 'Campo obrigatório!';
                        }
                        return null;
                      },
                    ),
                    Row(children: [
                      const Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Text(
                                '2 - Selecione os serviços a serem prestados',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                              ))),
                    ]),
                    Ink(
                          decoration: const ShapeDecoration(shape: CircleBorder(), color: Colors.purpleAccent),
                          child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                
                              ),
                              onPressed: () => controller.editAssists()),
                          width: 40,
                          height: 40),
                    Obx(
                      () => renderAssists(controller.selectedAssists),
                    ),
                    Row(children: [
                      const Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 25),
                              child: Text(
                                '3 - Revise os itens selecionados antes de confirmar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                              ))),
                    ]),
                    Row(children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              final isValidForm = controller.formKey.currentState!.validate();
                              isValidForm ? controller.finishStartOrder() : null;
                            },
                                                        
                            child: Obx(() {
                                if (controller.screenState.value ==
                                    OrderState.creating) {
                                  return const Text("Confirmar");
                                } else {
                                  return const Text("Finalizar");
                                }
                              },
                            )))
                    ]),
                  ],
                ),
              ),
            );
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Criação de Ordem de Serviço"),
        ),
        body: Container(
            constraints: const BoxConstraints.expand(),
            padding: const EdgeInsets.all(10.0),
            child: controller.obx((state) => buildForm(context),
                onLoading: const Center(child: CircularProgressIndicator()))));
  }

}