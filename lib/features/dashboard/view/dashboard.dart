import 'package:dog_app/features/breed_image_list/breed_images_list.dart';
import 'package:dog_app/features/breed_random/random_breed.dart';
import 'package:dog_app/features/dashboard/cubit/get_breed_names_cubit.dart';
import 'package:dog_app/features/dashboard/cubit/get_sub_breed_names_cubit.dart';
import 'package:dog_app/features/dashboard/view/widgets/app_bar.dart';
import 'package:dog_app/features/sub_breed_image_list/sub_breed_image_list.dart';
import 'package:dog_app/features/sub_breed_random/random_sub_breed.dart';
import 'package:dog_app/utils/_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    context.read<GetBreedNamesCubit>().getBreedNames(isFirstTimeGetting: true);
    context.read<GetSubBreedNamesCubit>().getSubBreedNames(
          selectedBreed: 'affenpinscher',
          isFirsTimeGetting: true,
          tabToUpdate: null,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Adapt.initContext(context);
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: DashBoardAppBar(),
        body: TabBarView(
          children: [
            RandomBreed(),
            BreedImageList(),
            RandomSubBreed(),
            SubBreedImageList()
          ],
        ),
      ),
    );
  }
}
