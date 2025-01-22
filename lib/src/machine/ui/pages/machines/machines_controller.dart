import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/di/add_machine_binding.dart';
import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/get_machines_use_case.dart';
import 'package:traga_monedas/src/machine/ui/pages/add_machine/add_machine_page.dart';
import 'package:traga_monedas/src/point/data/requests/machine/machine_request.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class MachinesController extends GetxController {
  GetMachinesUseCase getMachinesUseCase;
  List<MachineEntity> machines = [];
  bool validando = false;

  MachinesController({
    required this.getMachinesUseCase,
  });

  @override
  void onReady() {
    getMachines();
    super.onReady();
  }

  Future<void> getMachines() async {
    validando = true;
    update([validando]);
    ResultType<List<MachineEntity>, ErrorEntity> resultType =
        await getMachinesUseCase.execute(machineRequest: MachineRequest());
    if (resultType is Success) {
      List<MachineEntity> results = resultType.data as List<MachineEntity>;
      machines = results;
    } else {}
    validando = false;
    update([validandoIdGet, machinesIdGet]);
  }

  void goAdd() async {
    MachineEntity? result = await Get.to(()=> const AddMachinePage(), binding:  AddMachineBinding());
    if(result != null){
      getMachines();
    }
  }
}
