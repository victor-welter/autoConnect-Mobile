// ignore_for_file: unused_element, library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import '../../configs/constants.dart';

import '../../extensions/int_ext.dart';

part 'configuracoes_model.g.dart';

class ConfiguracoesModel = _ConfiguracoesModel with _$ConfiguracoesModel;

abstract class _ConfiguracoesModel with Store {
  _ConfiguracoesModel();

  _ConfiguracoesModel.fromDatabase(Map data) {
    _biometria = data['BIOMETRIA'];
    _synkedData = data['SYNKED_DATA'];
    _darkTheme = data['DARK_THEME'];
    _textFactor = data['TEXT_FACTOR'];
  }

  @observable
  int _biometria = CadOptions.NAO;

  @observable
  int _synkedData = CadOptions.NAO;

  @observable
  int _darkTheme = CadOptions.NAO;

  @observable
  double _textFactor = 1;

  @action
  void setBiometria(int value) {
    _biometria = value;
  }

  @computed
  int get biometria => _biometria;

  @action
  void setSynkedData(int value) {
    _synkedData = value;
  }

  @computed
  int get synkedData => _synkedData;

  @action
  void setDarkTheme(int value) {
    _darkTheme = value;
  }

  @computed
  int get darkTheme => _darkTheme;

  @computed
  bool get isDarkTheme => _darkTheme.toBool();

  @action
  void setTextFactor(double value) {
    _textFactor = value;
  }

  @computed
  double get textFactor => _textFactor;
}
