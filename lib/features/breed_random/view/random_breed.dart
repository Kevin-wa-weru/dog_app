// ignore_for_file: prefer_const_constructors

import 'package:dog_app/features/breed_random/cubit/get_random_breed_cubit.dart';
import 'package:dog_app/features/dashboard/cubit/get_breed_names_cubit.dart';
import 'package:dog_app/utils/_index.dart';
import 'package:dog_app/widgets/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomBreed extends StatelessWidget {
  const RandomBreed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 30),
            child: Text(
              'Random image by breed',
              style: headline1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Text('Select breed:'),
          ),
          BlocBuilder<GetBreedNamesCubit, GetBreedNamesState>(
            builder: (context, state) {
              return state.when(initial: () {
                return Text('Getting breeds ...',
                    style: TextStyle(color: Colors.teal));
              }, loading: () {
                return Text('Getting breeds ...',
                    style: TextStyle(color: Colors.teal));
              }, loaded: (
                List<String> breedNames,
                String selectedBreedTabOne,
                String selectedBreedTabTwo,
                String selectedBreedTabThree,
                String selectedBreedTabFour,
              ) {
                return CustomDropDown(
                  dropdownWidth: Adapt.screenW() * 0.60,
                  action: DropDownActions.fetchRandomBreed,
                  recentValue: selectedBreedTabOne,
                  items: breedNames,
                  isBreed: true,
                );
              }, error: (String message) {
                return Text(message);
              });
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocConsumer<GetRandomBreedCubit, GetRandomBreedState>(
                listener: (context, state) {
                  state.when(
                      initial: () {},
                      loading: () {},
                      loaded: (String imageUrl, String selectedBreed) {},
                      error: (String errorMessage) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(errorMessage)),
                        );
                      });
                },
                builder: (context, state) {
                  return state.when(initial: () {
                    return Container();
                  }, loading: () {
                    return Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: const CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    );
                  }, loaded: (String imageUrl, String selectedBreed) {
                    if (imageUrl.isEmpty) {
                      return const Center(child: Text('Random image is empty'));
                    } else {
                      return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: CustomNetworkImage(
                            imageUrl: imageUrl,
                          ));
                    }
                  }, error: (String errorMessage) {
                    return Container();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
