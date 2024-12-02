import '../../configs/routes/web_routes.dart';
import '../../services/http_service.dart';

class RegistroCombustivelRepository {
  static Future<Map<String, dynamic>> registrarCombustivel(
      double voltagen, int idVeiculo) async {
    Map body = {
      "voltagem": voltagen,
      "id_veiculo": 2
    };

    return await HttpService.post(
      rota: WebRoutes.REGISTRAR_COMBUSTIVEL,
      body: body,
    );
  }
}
