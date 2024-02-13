import 'package:flutter/material.dart';

import '../../data/model/client_model.dart';

class ClientItem extends StatelessWidget {
  ClientModel? clientModel;

  ClientItem({
    super.key,
    required this.clientModel
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ListTile(
              onTap: () {

              },
              leading: CircleAvatar(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.asset('assets/icons/client.png'),
                  )
              ),
              title: Text('${clientModel?.name}'),
              subtitle: Text('${clientModel?.phoneNumber}')
          ),
          Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16
              ),
              child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black26
              )
          )
        ]
    );
  }
}