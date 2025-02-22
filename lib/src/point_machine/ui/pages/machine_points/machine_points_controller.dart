import 'package:get/get.dart';
import 'package:traga_monedas/src/home/di/home_slot_binding.dart';
import 'package:traga_monedas/src/home/ui/pages/home_slot/home_slot_page.dart';
import 'package:traga_monedas/src/point/di/add_point_machine_binding.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/point/domain/use_cases/get_points_machine_use_case.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point_machine/add_point_machine_page.dart';
import 'package:traga_monedas/src/utils/ui/arguments.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class MachinePointsController extends GetxController {
  GetPointsMachineUseCase getPointsMachineUseCase;
  List<PointMachineEntity> pointsMachine = [];
  bool validando = false;

  MachinePointsController({
    required this.getPointsMachineUseCase,
  });

  @override
  void onReady() {
    getPointsMachine();
    super.onReady();
  }

  Future<void> getPointsMachine() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<PointMachineEntity>, ErrorEntity> resultType =
        await getPointsMachineUseCase.execute();
    if (resultType is Success) {
      List<PointMachineEntity> results =
          resultType.data as List<PointMachineEntity>;
      pointsMachine = results;
    } else {
      pointsMachine = [];
      ErrorEntity errorEntity = resultType.error as ErrorEntity;
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: errorEntity.title);
    }
    validando = false;
    update([pointsMachineIdGet, validandoIdGet]);
  }

  void goAddPointMachine() async {
    PointMachineEntity? result = await Get.to<PointMachineEntity>(
        () => const AddPointMachinePage(),
        binding: AddPointMachineBinding());
    if (result != null) {
      getPointsMachine();
    }
  }

  void goToContentSlot(PointMachineEntity pointMachineSelected) {
    Get.to(
      () => const HomeSlotPage(),
      arguments: {
        pointMachineSelectedArgument: pointMachineSelected,
      },
      binding: HomeSlotBinding(),
    );
  }
}
