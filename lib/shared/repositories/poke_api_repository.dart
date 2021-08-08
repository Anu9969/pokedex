import 'dart:convert';

import 'package:pokedex/shared/models/poke_api.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/shared/utils/app_constants.dart';

class PokeApiRepository {
  Future<PokeApi> fetchPokemons() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.pokeApiUrl));

      return PokeApi.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
