
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:jobsy_flutter/Blocs/Get%20User/get_user_bloc.dart';
import 'package:jobsy_flutter/Blocs/UploadImage/image_upload_bloc.dart';
import 'package:jobsy_flutter/Ui/Utilities/ColorConstants.dart';

class ProfileChanger extends StatelessWidget {
  const ProfileChanger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageUploadBloc, ImageUploadState>(
      builder: (context, state) {
        return BlocBuilder<GetUserBloc, GetUserState>(
          builder: (context, state) {
            if (state is GetUserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetUserLoaded) {
              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            state is ImageUploadLoading
                                ? const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: CircularProgressIndicator(),
                                  )
                                : ImageNetwork(
                                    borderRadius: BorderRadius.circular(100),
                                    image: state.user.image ??
                                        "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                                    height: 50,
                                    width: 50,
                                    duration: 10,
                                    onPointer: true,
                                    debugPrint: false,
                                    fullScreen: false,
                                    onLoading: const CircularProgressIndicator(
                                      color: Colors.indigoAccent,
                                    ),
                                    onError: const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    onTap: () async {
                                      FileUploadInputElement input =
                                          FileUploadInputElement()
                                            ..accept = 'image/*';

                                      input.click();
                                      input.onChange.listen((event) {
                                        final files = input.files!.first;
                                        final reader = FileReader();
                                        reader.readAsDataUrl(files);
                                        reader.onLoadEnd.listen((event) {
                                          BlocProvider.of<ImageUploadBloc>(
                                                  context)
                                              .add(
                                            UpdateProfile(
                                                image: files, path: files.name),
                                          );
                                        });
                                      });
                                    },
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.user.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  state.user.email,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  state.user.phone ?? "07000000000",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.user.bio ?? "Bio",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: 10,
                    right: 10,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white54,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            state.user.location ?? "Location",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white54, fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (state is GetUserError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          },
        );
      },
    );
  }
}

