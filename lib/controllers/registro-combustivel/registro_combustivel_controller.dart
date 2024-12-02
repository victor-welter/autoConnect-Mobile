import '../../interfaces/iregistro_combustivel.dart';
import '../../repository/registro-combustivel/registro_combustivel.dart';

class RegistroCombustivelController implements IRegistroCombustivel {
  @override
  Future<void> registrarCombustivel(double voltagen, int idVeiculo) async {
    await RegistroCombustivelRepository.registrarCombustivel(
        voltagen, idVeiculo);
  }
}
