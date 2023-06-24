import 'package:dev_app/domain/entity/dev.dart';
import 'package:dev_app/domain/entity/dto/dev_dto.dart';
import 'package:dev_app/domain/service/dev_service.dart';
import 'package:flutter/material.dart';

class DevScreen extends StatefulWidget {
  const DevScreen({super.key});

  @override
  State<DevScreen> createState() => _DevScreenState();
}

class _DevScreenState extends State<DevScreen> {
  DevService service = DevService();

  final TextEditingController _textEditingController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    TextField(),
                    TextButton(
                      onPressed: () => dateDialog(),
                      child: Text(
                        selectedDate.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: value,
                max: 100,
                divisions: 5,
                label: value.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    this.value = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () => service.save(
                  DevDTO(
                    name: 'IDK',
                    total: 2.78,
                    date: DateTime.now(),
                  ),
                ),
                child: const Text('data'),
              ),
              ElevatedButton(
                onPressed: () => countData(),
                child: const Text('count'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dateDialog() async {
    final DateTime? dt = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate.subtract(
          const Duration(days: 365),
        ),
        lastDate: selectedDate);
    if (dt != null) {
      setState(() {
        selectedDate = dt;
      });
    }
  }

  countData() async {
    List<Dev> dList = await service.findAll();
    print(dList.length);
  }
}
