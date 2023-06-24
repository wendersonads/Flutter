import 'package:api_connect/domain/entity/client.dart';
import 'package:api_connect/domain/service/client_service.dart';
import 'package:flutter/material.dart';

class ClientView extends StatefulWidget {
  const ClientView({super.key});

  @override
  State<ClientView> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView> {
  ClientService service = ClientService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: service.findAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => clientCard(
                snapshot.data![index],
              ),
            );
          }
        },
      ),
    );
  }

  clientCard(Client client) {
    return Card(
      child: Column(
        children: [
          Text(
            client.id.toString(),
          ),
          Text(
            client.name,
          ),
          Text(
            client.clazz,
          ),
        ],
      ),
    );
  }
}
