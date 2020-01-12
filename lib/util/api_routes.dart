import 'package:travel_gear_mobile/util/environment.dart';

const developmentApiUrl = 'http://travelgear.test/api/';
const productionApiUrl = 'http://travelgear.test/api/';

const baseApiUrl = (development) ? developmentApiUrl : productionApiUrl;