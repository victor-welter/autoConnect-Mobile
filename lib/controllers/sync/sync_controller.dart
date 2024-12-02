import '../../models/sessao/sessao_model.dart';
import '../../services/service_locator.dart';
import '../../stores/sync/sync_store.dart';

class SyncController {
  static Future<void> syncService() async {
    final stateView = getIt<SyncStore>();

    stateView.resetState();

    double incValue = 0.025;

    stateView.setTotalDownload(1);
    stateView.setProgressDownload(0);

    if (!stateView.monitoramentosSync) {
      stateView.setMessageSync('Buscando monitoramentos');
      // await MonitoramentoController.downloadData();
      stateView.monitoramentosSynked();
    }
    stateView.incrementProgress(value: incValue);

    //Deixar sempre por último
    //Indica que o usuário logado realizou a primeira sincronização
    await _synkedData();
  }

  static Future<void> _synkedData() async {
    final sessao = getIt<SessaoModel>();

    // sessao.configuracoes.setSynkedData(CadOptions.SIM);

    // await UsuariosController.updateConfiguracoes();
  }
}
