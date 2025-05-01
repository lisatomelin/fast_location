import 'package:fast_location/src/modules/home/model/address_model.dart';
import 'package:mobx/mobx.dart';
part 'history_controller.g.dart';

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
    isLoading = false;
  }

  @action
  void addToSearchHistory(AddressModel address) {
    addressHistoryList.insert(0, address);
  }
}