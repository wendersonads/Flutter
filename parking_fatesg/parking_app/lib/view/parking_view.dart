import 'package:flutter/material.dart';
import 'package:parking_app/domain/service/spot_service.dart';

class ParkingView extends StatefulWidget {
  const ParkingView({super.key});

  @override
  State<ParkingView> createState() => _ParkingViewState();
}

class _ParkingViewState extends State<ParkingView> {
  SpotService service = SpotService();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.lime),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(controller: controller,
                      decoration: const InputDecoration(isDense: true),
                    ),
                  ),
                  IconButton(
                    onPressed: () => addCar(),
                    icon: const Icon(Icons.plus_one_rounded),
                  ),
                  IconButton(
                    onPressed: () => removeCar(),
                    icon: const Icon(Icons.exit_to_app_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  addCar() {
    if (controller.text.isNotEmpty) {
      service.save(controller.text);
    }
  }

  removeCar() {
    if (controller.text.isNotEmpty) {
      service.update(controller.text);
    }
  }
}
