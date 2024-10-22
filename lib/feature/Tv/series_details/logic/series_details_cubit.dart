import 'package:clean_architecture_app/feature/Tv/series_details/data/repo/series_details_repo.dart';
import 'package:clean_architecture_app/feature/Tv/series_details/logic/series_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/networking/api_constants.dart';
import '../data/model/series_details.dart';

class SeriesDetailsCubit extends Cubit<SeriesDetailsState<SeriesDetailsModel>> {
  SeriesDetailsCubit(this.seriesDetailsRepo)
      : super(SeriesDetailsStateInitial());
  final SeriesDetailsRepo seriesDetailsRepo;
  SeriesDetailsModel? seriesDetailsList;

  void getSeriesDetails({required int seriesId}) async {
    emit(SeriesDetailsStateLoading());
    final data = await seriesDetailsRepo.getSeriesDetails(queries: {
      'api_key': ApiConstance.apiKey,
    }, id: seriesId);
    data.when(success: (SeriesDetailsModel seriesDetailsModel) {
      seriesDetailsList = seriesDetailsModel;
      emit(SeriesDetailsStateSuccess(seriesDetailsModel));
    }, failure: (error) {
      print(error);
      emit(SeriesDetailsStateError(error.apiErrorModel.statusMessage!));
    });
  }
}
