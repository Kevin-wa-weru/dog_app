part of dog_app_widgets;

//Reusable dropdown. OnChange action changes with current tab view

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    super.key,
    required this.dropdownWidth,
    required this.items,
    required this.action,
    this.recentValue,
    required this.isBreed,
  });
  final double dropdownWidth;
  final List<String> items;
  final DropDownActions action;
  final String? recentValue;
  final bool? isBreed;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;

  @override
  void initState() {
    setState(() {
      selectedValue = widget.recentValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.dropdownWidth,
      height: Adapt.screenH() * 0.05,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(Adapt.px(10)),
        ),
        border: Border.all(
          color: Colors.black12,
          width: 1.0,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: DropdownButton(
              isDense: true,
              isExpanded: true,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              value: selectedValue,
              icon: const Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Icon(
                  Icons.arrow_downward,
                  size: 20,
                ),
              ),
              underline: Container(),
              items: LinkedHashSet<String>.from(widget.items)
                  .toList()
                  .map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });

                switch (widget.action) {
                  case DropDownActions.fetchRandomBreed:
                    context
                        .read<GetRandomBreedCubit>()
                        .getRandomBreedImage(breedName: selectedValue!);
                    context.read<GetBreedNamesCubit>().getBreedNames(
                        isFirstTimeGetting: false,
                        selectedbreedName: selectedValue,
                        currentTab: CurrentTabScreen.tabOne);

                    break;
                  case DropDownActions.fetchBreedImageList:
                    context
                        .read<GetBreedImagesCubit>()
                        .getBreedImages(breedName: selectedValue!);
                    context.read<GetBreedNamesCubit>().getBreedNames(
                        isFirstTimeGetting: false,
                        selectedbreedName: selectedValue,
                        currentTab: CurrentTabScreen.tabTwo);
                    break;
                  case DropDownActions.fetchSubBreedNamesTabThree:
                    context.read<GetBreedNamesCubit>().getBreedNames(
                        isFirstTimeGetting: false,
                        currentTab: CurrentTabScreen.tabThree,
                        selectedbreedName: selectedValue);
                    context.read<GetSubBreedNamesCubit>().getSubBreedNames(
                        selectedBreed: selectedValue!,
                        tabToUpdate: CurrentTabScreen.tabThree,
                        isFirsTimeGetting: false);
                    break;
                  case DropDownActions.fetchSubBreedNamesTabFour:
                    context.read<GetBreedNamesCubit>().getBreedNames(
                        isFirstTimeGetting: false,
                        currentTab: CurrentTabScreen.tabFour,
                        selectedbreedName: selectedValue);
                    context.read<GetSubBreedNamesCubit>().getSubBreedNames(
                        selectedBreed: selectedValue!,
                        tabToUpdate: CurrentTabScreen.tabFour,
                        isFirsTimeGetting: false);
                    break;
                  case DropDownActions.fetchRandomSubBreed:
                    context
                        .read<GetRandomSubBreedCubit>()
                        .getRandomSubBreedImage(subBreedName: selectedValue!);

                    break;
                  case DropDownActions.fetchSubBreedImages:
                    context.read<GetSubBreedImagesCubit>().getSubBreedImages(
                          subBreedName: selectedValue!,
                        );

                    break;
                  default:
                }
              }),
        ),
      ),
    );
  }
}
