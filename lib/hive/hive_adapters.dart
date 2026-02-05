import 'package:hive_ce/hive.dart';
import 'package:oil_erp/hive/models.dart';

@GenerateAdapters([
  AdapterSpec<EmpTraining>(),
])
part 'hive_adapters.g.dart';
