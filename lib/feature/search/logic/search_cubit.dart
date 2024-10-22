import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/networking/api_constants.dart';
import '../data/model/search_model.dart';
import '../data/repo/search_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState<SearchModel>> {
  SearchCubit(this.searchRepo) : super(SearchStateInitial());
  final SearchRepo searchRepo;
  SearchModel? searchList;
  bool isSearch = false;

  void onCheckSearch(val) {
    if (val == '') {
      isSearch = false;
    }
    emit(SearchStateEmpty());
  }

  void emitSearch({required String text}) async {
    emit(SearchStateLoading());
    final data = await searchRepo.getActors(
      queries: {'api_key': ApiConstance.apiKey, 'query': text},
    );
    data.when(success: (SearchModel searchModel) {
      searchList = searchModel;
      isSearch = true;
      emit(SearchStateSuccess(searchModel));
    }, failure: (error) {
      emit(SearchStateError(error.apiErrorModel.statusMessage!));
    });
  }
}
