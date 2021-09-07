import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/modules/pages/home/home_store.dart';
import 'package:pokedex/modules/pages/home/widgets/generation_item.dart';
import 'package:pokedex/modules/pages/pokemon_details/widgets/pokemon_panel/pokemon_mobile_panel.dart';
import 'package:pokedex/shared/models/pokemon.dart';
import 'package:pokedex/shared/stores/pokeapi_store.dart';
import 'package:pokedex/theme/app_theme.dart';

class PokemonGenerationFilter extends StatelessWidget {
  static final PokeApiStore pokeApiStore = GetIt.instance<PokeApiStore>();
  final ScrollController scrollController;
  final HomeStore homeStore;

  const PokemonGenerationFilter(
      {Key? key, required this.homeStore, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final horizontalPadding = getDetailsPanelsPadding(size);

    return Observer(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
            left: horizontalPadding, right: horizontalPadding, top: 28),
        child: Stack(
          children: [
            if (pokeApiStore.pokemonFilter.generationFilter != null)
              SizedBox(
                height: 40,
              ),
            NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [];
              },
              body: GridView.builder(
                controller: scrollController,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 3 / 2,
                ),
                itemBuilder: (context, index) {
                  final generation = Generation.values[index];

                  Color? color =
                      pokeApiStore.pokemonFilter.generationFilter == generation
                          ? AppTheme.colors.selectedGenerationFilter
                          : Colors.white;

                  return GenerationItemWidget(
                    generation: generation,
                    color: color,
                    onClick: () {
                      if (pokeApiStore.pokemonFilter.generationFilter != null &&
                          pokeApiStore.pokemonFilter.generationFilter ==
                              generation) {
                        pokeApiStore.clearGenerationFilter();
                      } else {
                        pokeApiStore.addGenerationFilter(generation);
                      }

                      homeStore.closeFilter();
                    },
                  );
                },
                itemCount: Generation.values.length,
              ),
            ),
            if (pokeApiStore.pokemonFilter.generationFilter != null)
              Container(
                height: 40,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Click on the selected item to clear the filter",
                      style: AppTheme.texts.pokemonText,
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
