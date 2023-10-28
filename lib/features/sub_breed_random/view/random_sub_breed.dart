// ignore_for_file: prefer_const_constructors

import 'package:dog_app/features/dashboard/cubit/get_breed_names_cubit.dart';
import 'package:dog_app/features/dashboard/cubit/get_sub_breed_names_cubit.dart';
import 'package:dog_app/features/sub_breed_random/cubit/get_random_sub_breed_cubit.dart';
import 'package:dog_app/utils/_index.dart';
import 'package:dog_app/widgets/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomSubBreed extends StatelessWidget {
  const RandomSubBreed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 40),
            child: Text(
              'Fetch random image by breed and sub breed',
              style: headline1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('1. Select breed:'),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Text('2. Select sub-breed:'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<GetBreedNamesCubit, GetBreedNamesState>(
                builder: (context, state) {
                  return state.when(initial: () {
                    return Text('Getting breeds',
                        style: TextStyle(color: Colors.teal));
                  }, loading: () {
                    return Text('Getting breeds',
                        style: TextStyle(color: Colors.teal));
                  }, loaded: (
                    List<String> breedNames,
                    String selectedBreedTabOne,
                    String selectedBreedTabTwo,
                    String selectedBreedTabThree,
                    String selectedBreedTabFour,
                  ) {
                    return CustomDropDown(
                      dropdownWidth: Adapt.screenW() * 0.40,
                      action: DropDownActions.fetchSubBreedNamesTabThree,
                      recentValue: selectedBreedTabThree,
                      items: breedNames,
                      isBreed: true,
                    );
                  }, error: (String message) {
                    return Text(message);
                  });
                },
              ),
              BlocBuilder<GetSubBreedNamesCubit, GetSubBreedNamesState>(
                builder: (context, state) {
                  return state.when(initial: () {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text('Getting sub breeds ...',
                          style: TextStyle(color: Colors.teal)),
                    );
                  }, loading: () {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text('Getting sub breeds ...',
                          style: TextStyle(color: Colors.teal)),
                    );
                  }, loaded: (
                    List<String> subBreedNamesTabThree,
                    List<String> subBreedNamesTabFour,
                  ) {
                    if (subBreedNamesTabThree.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text('Has no subBreeds.',
                            style: TextStyle(color: Colors.red)),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: CustomDropDown(
                          dropdownWidth: Adapt.screenW() * 0.40,
                          action: DropDownActions.fetchRandomSubBreed,
                          recentValue: subBreedNamesTabThree.first,
                          items: subBreedNamesTabThree,
                          isBreed: true,
                        ),
                      );
                    }
                  }, error: (String message) {
                    return const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text('Error getting subbreeds.',
                          style: TextStyle(color: Colors.red)),
                    );
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: SingleChildScrollView(
              child:
                  BlocConsumer<GetRandomSubBreedCubit, GetRandomSubBreedState>(
                listener: (context, state) {
                  state.when(
                      initial: () {},
                      loading: () {},
                      loaded: (message) {},
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
                    return const CircularProgressIndicator(
                      color: Colors.teal,
                    );
                  }, loaded: (String imageUrl) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Image.network(imageUrl),
                    );
                  }, error: (String erroMessage) {
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
