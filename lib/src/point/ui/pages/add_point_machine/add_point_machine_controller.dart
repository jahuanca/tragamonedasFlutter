import 'package:get/get.dart';
import 'package:traga_monedas/src/machine/di/add_machine_binding.dart';
import 'package:traga_monedas/src/machine/domain/entities/machine_entity.dart';
import 'package:traga_monedas/src/machine/domain/use_cases/get_machines_use_case.dart';
import 'package:traga_monedas/src/machine/ui/pages/add_machine/add_machine_page.dart';
import 'package:traga_monedas/src/point/data/requests/machine/machine_request.dart';
import 'package:traga_monedas/src/point/data/requests/point_request.dart';
import 'package:traga_monedas/src/point/di/add_point_binding.dart';
import 'package:traga_monedas/src/point/domain/entities/point_entity.dart';
import 'package:traga_monedas/src/point/domain/entities/point_machine_entity.dart';
import 'package:traga_monedas/src/point/domain/use_cases/create_point_machine_use_case.dart';
import 'package:traga_monedas/src/point/domain/use_cases/get_points_use_case.dart';
import 'package:traga_monedas/src/point/ui/pages/add_point/add_point_page.dart';
import 'package:traga_monedas/src/utils/ui/ids_get.dart';
import 'package:utils/utils.dart';

class AddPointMachineController extends GetxController {
  GetPointsUseCase getPointsUseCase;
  GetMachinesUseCase getMachinesUseCase;
  List<MachineEntity> machines = [];
  List<PointEntity> points = [];
  bool validando = false;
  MachineEntity? machineSelected;
  double? porcentageSelected;
  PointEntity? pointSelected;
  String? errorPoint, errorMachine, errorPorcentage;
  CreatePointMachineUseCase createPointMachineUseCase;

  AddPointMachineController({
    required this.getPointsUseCase,
    required this.getMachinesUseCase,
    required this.createPointMachineUseCase,
  });

  @override
  void onReady() {
    getPoints();
    getMachines();
    super.onReady();
  }

  void getPoints() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<PointEntity>, ErrorEntity> resultType =
        await getPointsUseCase.execute(
            pointRequest: PointRequest(
      hasPointMachine: false,
    ));
    validando = false;
    update([validandoIdGet]);
    if (resultType is Success) {
      List<PointEntity> results = resultType.data as List<PointEntity>;
      points = results;
    } else {
      ErrorEntity errorEntity = resultType.error as ErrorEntity;
      showSnackbarWidget(
        context: Get.overlayContext!,
        typeSnackbar: TypeSnackbar.error,
        message: errorEntity.title,
      );
    }
    update([pointsIdGet]);
  }

  void getMachines() async {
    validando = true;
    update([validandoIdGet]);
    ResultType<List<MachineEntity>, ErrorEntity> resultType =
        await getMachinesUseCase.execute(
            machineRequest: MachineRequest(
      hasPointMachine: false,
    ));
    validando = false;
    update([validandoIdGet]);
    if (resultType is Success) {
      List<MachineEntity> results = resultType.data as List<MachineEntity>;
      machines = results;
    } else {
      ErrorEntity errorEntity = resultType.error as ErrorEntity;
      showSnackbarWidget(
        context: Get.overlayContext!,
        typeSnackbar: TypeSnackbar.error,
        message: errorEntity.title,
      );
    }
    update([machinesIdGet]);
  }

  void onChangeMachine(dynamic id) {
    machineSelected = machines.firstWhereOrNull(
      (e) => e.id == id,
    );
    if (machineSelected != null) {
      errorMachine = null;
    } else {
      errorMachine = 'Maquina es requerida';
      machineSelected = null;
    }
  }

  void onChangePoint(dynamic id) {
    pointSelected = points.firstWhereOrNull(
      (e) => e.id == id,
    );
    porcentageSelected = pointSelected?.porcentage;
    if (pointSelected != null) {
      errorPoint = null;
    } else {
      errorPoint = 'Maquina es requerida';
      pointSelected = null;
    }
    update([porcentageIdGet]);
  }

  String? validar() {
    onChangeMachine(machineSelected?.id);
    onChangePoint(pointSelected?.id);
    return [
      errorPorcentage,
      errorMachine,
      errorPoint,
    ].firstWhereOrNull(
      (e) => e != null,
    );
  }

  void createPointMachine() async {
    String? message = validar();
    if (message != null) {
      showSnackbarWidget(
          context: Get.overlayContext!,
          typeSnackbar: TypeSnackbar.error,
          message: message);
      return;
    }
    validando = true;
    update([validandoIdGet]);
    ResultType<PointMachineEntity, ErrorEntity> resultType =
        await createPointMachineUseCase.execute(
      pointMachineEntity: PointMachineEntity(
        idPoint: pointSelected!.id!,
        idMachine: machineSelected!.id!,
        porcentage: porcentageSelected!,
      ),
    );
    validando = false;
    update([validandoIdGet]);
    if (resultType is Success) {
      PointMachineEntity pointMachineEntity =
          resultType.data as PointMachineEntity;
      Get.back(
        result: pointMachineEntity,
      );
    } else {
      ErrorEntity errorEntity = resultType.error as ErrorEntity;
      await showSnackbarWidget(
        context: Get.context!,
        typeSnackbar: TypeSnackbar.error,
        message: errorEntity.title,
      );
    }
  }

  void goAddPoint() async {
    PointEntity? result = await Get.to<PointEntity?>(() => const AddPointPage(),
        binding: AddPointBinding());
    if (result != null) {
      getPoints();
    }
  }

  void goAddMachine() async {
    MachineEntity? result = await Get.to<MachineEntity?>(
        () => const AddMachinePage(),
        binding: AddMachineBinding());
    if (result != null) {
      getMachines();
    }
  }
}
