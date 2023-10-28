import 'package:dog_app/features/breed_image_list/cubit/get_breed_images_cubit.dart';
import 'package:dog_app/features/dashboard/cubit/get_breed_names_cubit.dart';
import 'package:dog_app/utils/_index.dart';
import 'package:dog_app/widgets/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreedImageList extends StatelessWidget {
  const BreedImageList({
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
              'Fetch Images list by breed',
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
                return const Text('Getting breeds ...',
                    style: TextStyle(color: Colors.teal));
              }, loading: () {
                return const Text('Getting breeds ...',
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
                  action: DropDownActions.fetchBreedImageList,
                  recentValue: selectedBreedTabTwo,
                  items: breedNames,
                  isBreed: true,
                );
              }, error: (String message) {
                return Text(message);
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<GetBreedImagesCubit, GetBreedImagesState>(
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
                return const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                );
              }, loaded: (
                List<String> breedImageUrls,
              ) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 2,
                    ),
                    itemCount: breedImageUrls.length,
                    itemBuilder: (context, index) {
                      return CustomNetworkImage(
                        imageUrl: breedImageUrls[index],
                      );
                    },
                  ),
                );
              }, error: (String errorMessage) {
                return Container();
              });
            },
          )
        ],
      ),
    );
  }
}
