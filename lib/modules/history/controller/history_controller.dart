import 'package:fast_location/modules/home/model/address_model.dart';
import 'package:mobx/mobx.dart';

part 'history_controller.g.dart'; // Geração automática do MobX

class HistoryController extends _HistoryController with _$HistoryController {}

abstract class _HistoryController with Store {
  @observable
  bool isLoading = false;

  @observable
  bool hasAddress = false;

  @observable
  ObservableList<AddressModel> addressHistoryList =
      ObservableList<AddressModel>();

  @action
  Future<void> loadData() async {
    isLoading = true;
    // Lógica para carregar dados do histórico
    await Future.delayed(const Duration(seconds: 2)); // Simulação de carregamento
    isLoading = false;
  }

  @action
  void addToSearchHistory(AddressModel address) {
    addressHistoryList.insert(0, address);
    hasAddress = addressHistoryList.isNotEmpty;
  }
}