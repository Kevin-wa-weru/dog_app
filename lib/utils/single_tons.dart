part of dog_app_utils;

//  This class registers each cubit before using them.
//
//BloC is used for state management. Services are passed to
//each cubit that requires them it

class Singletons {
  static final _fetchService = FetchService();
  static final _nameService = NameService();

  static List<BlocProvider> registerCubits() => [
        BlocProvider<GetBreedImagesCubit>(
          create: (context) => GetBreedImagesCubit(fetchService: _fetchService),
        ),
        BlocProvider<GetRandomBreedCubit>(
          create: (context) => GetRandomBreedCubit(fetchService: _fetchService),
        ),
        BlocProvider<GetRandomSubBreedCubit>(
          create: (context) =>
              GetRandomSubBreedCubit(fetchService: _fetchService),
        ),
        BlocProvider<GetSubBreedImagesCubit>(
          create: (context) => GetSubBreedImagesCubit(
            fetchService: _fetchService,
          ),
        ),
        BlocProvider<GetBreedNamesCubit>(
          create: (context) => GetBreedNamesCubit(
              fetchService: _fetchService, nameService: _nameService),
        ),
        BlocProvider<GetSubBreedNamesCubit>(
            create: (context) => GetSubBreedNamesCubit(
                fetchService: _fetchService, nameService: _nameService)),
      ];
}
