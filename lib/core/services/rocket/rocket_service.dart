import 'package:xspace/core/models/rocket_details_response_model.dart';
import 'package:xspace/core/models/rocket_list_response_model.dart.dart';
import 'package:xspace/core/services/service_base/service_base.dart';
import 'package:xspace/utils/utils.dart';

class SpaceXService {
  Future<List<RocketListResponseModel>> getRocketList() async {
    var response = await ServiceBase.get(
      url: 'rockets',
      headers: {},
    );
    if (response.statusCode == 200) {
      return getRocketListResponseModelFromJson(response.body);
    } else {
      throw Utils.handleExecption(response);
    }
  }

  Future<RocketDetailsResponseModel> getRocketDetails(String id) async {
    var response = await ServiceBase.get(
      headers: {},
      url: 'rockets/$id',
    );
    if (response.statusCode == 200) {
      return rocketDetailsResponseModelFromJson(response.body);
    } else {
      throw Utils.handleExecption(response);
    }
  }
}
