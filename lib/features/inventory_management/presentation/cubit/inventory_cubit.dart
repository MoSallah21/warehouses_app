import 'package:flutter_bloc/flutter_bloc.dart';
part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit(): super(InventoryInitState());

  static InventoryCubit get(context) => BlocProvider.of(context);




}