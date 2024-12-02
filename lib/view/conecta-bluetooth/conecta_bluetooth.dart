import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../controllers/registro-combustivel/registro_combustivel_controller.dart';
import '../../widgets/cs_app_bar.dart';
import '../../widgets/cs_elevated_button.dart';

class ConectaBluetooth extends StatefulWidget {
  const ConectaBluetooth({super.key});

  @override
  State<ConectaBluetooth> createState() => _ConectaBluetoothState();
}

class _ConectaBluetoothState extends State<ConectaBluetooth> {
  // Lista para armazenar os resultados do scan
  List<ScanResult> scanResults = [];
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? targetCharacteristic;
  List<String> values = [];

  // UUIDs do serviço e da característica (mesmos do ESP32)
  final String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String characteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

  // Função para iniciar o scan
  void startScan() async {
    // Limpar resultados anteriores
    setState(() {
      scanResults.clear();
    });

    // Iniciar o scan
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    // Ouvir o stream de resultados do scan
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults = results;
      });
    });

    // Aguardar alguns segundos para coletar os resultados
    await Future.delayed(const Duration(seconds: 4));

    // Parar o scan
    await FlutterBluePlus.stopScan();

    // Conectar ao dispositivo ESP32 assim que encontrado
    for (var result in scanResults) {
      if (result.device.advName == "ESP32-BLE") {
        connectToDevice(result.device);
        break;
      }
    }
  }

  // Função para conectar ao dispositivo
  void connectToDevice(BluetoothDevice device) async {
    // Conectar ao dispositivo
    await device.connect();
    setState(() {
      connectedDevice = device;
    });

    // Descobrir serviços e características do dispositivo
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == serviceUuid) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == characteristicUuid) {
            targetCharacteristic = characteristic;
            // Ativar notificações para receber os dados
            await targetCharacteristic!.setNotifyValue(true);
            targetCharacteristic!.value.listen((value) async {
              try {
                // Converter os valores recebidos para uma string
                String received = String.fromCharCodes(value);

                // Converter a string para um double
                double parsedValue = double.parse(received);

                // Adicionar à lista de valores recebidos
                setState(() {
                  values.add(received);
                });

                await RegistroCombustivelController()
                    .registrarCombustivel(parsedValue, 2);
              } catch (_) {}
            });
            break;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    FlutterBluePlus.stopScan();
    connectedDevice?.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CsAppBar(title: 'Consulta Combustível'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CsElevatedButton(
                label: 'Iniciar Scan',
                onPressed: startScan,
              ),
            ),

            const Text(
              'Dispositivos encontrados:',
              style: TextStyle(fontSize: 20),
            ),

            // Exibir os dispositivos encontrados
            Expanded(
              child: ListView.builder(
                itemCount: scanResults.length,
                itemBuilder: (context, index) {
                  final result = scanResults[index];
                  return ListTile(
                    title: Text(result.device.advName.isEmpty
                        ? 'Desconhecido'
                        : result.device.advName),
                    subtitle: Text('RSSI: ${result.rssi}'),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Valores recebidos:',
              style: TextStyle(fontSize: 20),
            ),

            // Exibir os valores recebidos do ESP32
            Expanded(
              child: ListView.builder(
                itemCount: values.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Valor: ${values[index]}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
