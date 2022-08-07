import 'package:flutter/material.dart';

class SegundaTela extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey();

  final TextEditingController _controller = TextEditingController();
  SegundaTela({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Formulário')),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo Obrigatorio';
                  }

                  return null;
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  bool validado = _formkey.currentState?.validate() ?? false;
                  if (validado) {
                    Navigator.of(context).pop(_controller.text);
                  } // não entendi
                },
                child: const Text('Salvar'))
          ]),
        ),
      ),
    );
  }
}