import 'package:bloc_example/Shopping/Home/HomeLogic/bloc/home_logic_bloc.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_category_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model.dart';
import 'package:bloc_example/Shopping/Home/HomeModel/home_model_all.dart';
import 'package:bloc_example/Utils/Images/image_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ShoppingHome extends StatefulWidget {
  const ShoppingHome({super.key});

  @override
  State<ShoppingHome> createState() => _ShoppingHomeState();
}

class _ShoppingHomeState extends State<ShoppingHome> {
  final TextEditingController _searchController = TextEditingController();
  List<HomeCategoryModel>? categoryModel;
  List<HomeAllProductModel>? allProductModel;
  List<HomeBanner>? bannerModel;
  String? locationAddress;
  final GlobalKey<ScaffoldMessengerState> _speechService =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget createShoppingAppSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.13,
          ),
          BlocListener<HomeLogicBloc, HomeLogicState>(
            listener: (context, state) {
              if (state is HomeSpeechSuccess) {
                _searchController.text = state.recognizedString;
                // call API
              } else if (state is HomeSpeechFailure) {
                _speechService.currentState?.showSnackBar(const SnackBar(
                  content: Text("Failure to recognize text"),
                  duration: Duration(milliseconds: 200),
                ));
              } else if (state is HomeSpeechLoading) {
                _speechService.currentState?.showSnackBar(const SnackBar(
                  content: Text("Recognizing"),
                ));
              }
            },
            child: SearchBar(
              hintText: "What are you looking for ?",
              shadowColor: MaterialStateProperty.all<Color>(Colors.white),
              overlayColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              controller: _searchController,
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 15)),
              leading: const Icon(Icons.search),
              trailing: [
                TextButton(
                    onPressed: () {
                      BlocProvider.of<HomeLogicBloc>(context)
                          .add(HomePageSpeechEvent());
                    },
                    child: const Icon(Icons.mic))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEA3A60),
      ),
      body: BlocBuilder<HomeLogicBloc, HomeLogicState>(
        builder: (context, state) {
          // storing value in arrays pre defined
          if (state is HomeLogicInitial) {
            BlocProvider.of<HomeLogicBloc>(context).add(HomePageCallerEvent());
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLogicSuccess) {
            categoryModel = state.modelHome.allCategory;
            allProductModel = state.modelHome.allProductModel;
            locationAddress = state.locationString.toString();
            bannerModel = state.modelHome.bannerList;

            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 0),
                            color: const Color(0xFFEA3A60),
                            height: MediaQuery.of(context).size.height * 0.17,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("/profile");
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20.0))),
                                        child: ImageServiceUtil
                                            .getProfileImageWidgetFromName(
                                                state.authModel.email),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(state.authModel.displayName,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w700)),
                                    const Spacer(),
                                    const Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    Text(locationAddress ?? "",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400))
                                  ],
                                )
                              ],
                            )),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 40, left: 20, right: 15),
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bannerModel?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 15.0,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              height: 200,
                                              child: ImageServiceUtil.getImage(
                                                  bannerModel?[index]
                                                          .mobileImageBanner ??
                                                      "")),
                                        ));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryModel?.length ?? 0,
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Container(
                                          // width: 100,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFF4F4F4),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: TextButton(
                                            child: Text(categoryModel?[index]
                                                    .categoryName ??
                                                ""),
                                            onPressed: () {
                                              //presss Button event
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10),
                                  height: MediaQuery.of(context).size.height -
                                      200 -
                                      70 -
                                      230,
                                  child: MasonryGridView.builder(
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                "/details",
                                                arguments:
                                                    allProductModel?[index].id);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, top: 3),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                  child:
                                                      ImageServiceUtil.getImage(
                                                          allProductModel?[
                                                                      index]
                                                                  .images ??
                                                              ""),
                                                ),
                                                Text(
                                                    "\$${allProductModel?[index].price}",
                                                    style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                                Text(
                                                    allProductModel?[index]
                                                            .title ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[600]))
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                            ],
                          ),
                        )
                      ],
                    ),
                    createShoppingAppSearchBar()
                  ],
                ),
              ),
            );
          } else if (state is HomeLogicLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeLogicFailure) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded, size: 40),
                SizedBox(
                  height: 3,
                ),
                Text("Some Error Happended,",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ],
            );
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber_rounded, size: 40),
                  SizedBox(
                    height: 3,
                  ),
                  Text("Some Error Happended,",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
