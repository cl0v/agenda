import 'package:agenda/repositories/service.dart';
import 'package:agenda/src/features/service/models/service.dart';
import 'package:agenda/src/features/service/widgets/list_tile.dart';
import 'package:flutter/material.dart';

import '../authenticator.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<List<ServiceModel>>(
          stream: ServiceRepository.readAll(Authenticator.of(context).id),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<ServiceModel> l = snapshot.data ?? [];
            return ListView(
              children: l
                  .map((e) => ServiceListTile(
                        service: e,
                      ))
                  .toList(),
            );
          },
        ),
      );
  }
}