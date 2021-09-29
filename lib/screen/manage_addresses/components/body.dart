import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:truck/constants.dart';
import 'package:truck/model/Address.dart';
import 'package:truck/screen/edit_address/edit_address_screen.dart';
import 'package:truck/screen/manage_addresses/components/address_short_details_card.dart';
import 'package:truck/screen/my-globals.dart';
import 'package:truck/service/addresses_stream.dart';
import 'package:truck/service/database/user_database_helper.dart';
import 'package:truck/size_config.dart';
import '../components/address_box.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AddressesStream addressesStream = AddressesStream();
  int selectedIndex;
  final TextEditingController addresstextid = new TextEditingController();
  int selectedradio;
  setselcetedradio(int val) {
    setState(() {
      selectedradio = val;
      //print(addresstextid);
    });
  }

  @override
  void initState() {
    super.initState();
    addressesStream.init();
    selectedradio = 0;
  }

  @override
  void dispose() {
    super.dispose();
    addressesStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  //SizedBox(height: getProportionateScreenHeight(10)),
                  // Text(
                  //   "Manage Addresses",
                  //   style: headingStyle,
                  // ),
                  // Text(
                  //   "Swipe LEFT to Edit, Swipe RIGHT to Delete",
                  //   style: TextStyle(fontSize: 12),
                  // ),
                  //SizedBox(height: getProportionateScreenHeight(20)),
                  DefaultButton(
                    text: "Add New Address",
                    press: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAddressScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.3,
                    child: StreamBuilder<List<String>>(
                      stream: addressesStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final addresses = snapshot.data;
                          if (addresses.length == 0) {
                            return Center(
                              child: NothingToShowContainer(
                                iconPath: "assets/icons/add_location.svg",
                                secondaryMessage: "Add your first Address",
                              ),
                            );
                          }
                          return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: addresses.length,
                              itemBuilder: (context, index) {
                                return buildAddressItemCard(
                                    addresses[index], index);
                              });
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          final error = snapshot.error;
                          Logger().w(error.toString());
                        }
                        return Center(
                          child: NothingToShowContainer(
                            iconPath: "assets/icons/network_error.svg",
                            primaryMessage: "Something went wrong",
                            secondaryMessage: "Unable to connect to Database",
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    addressesStream.reload();
    return Future<void>.value();
  }

  Future<bool> deleteButtonCallback(
      BuildContext context, String addressId) async {
    final confirmDeletion = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to delete this Address ?"),
          actions: [
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );

    if (confirmDeletion) {
      bool status = false;
      String snackbarMessage;
      try {
        status =
            await UserDatabaseHelper().deleteAddressForCurrentUser(addressId);
        if (status == true) {
          snackbarMessage = "Address deleted successfully";
        } else {
          throw "Coulnd't delete address due to unknown reason";
        }
      } on FirebaseException catch (e) {
        Logger().w("Firebase Exception: $e");
        snackbarMessage = "Something went wrong";
      } catch (e) {
        Logger().w("Unknown Exception: $e");
        snackbarMessage = e.toString();
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage),
          ),
        );
      }
      await refreshPage();
      return status;
    }
    return false;
  }

  Future<bool> editButtonCallback(
      BuildContext context, String addressId) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditAddressScreen(addressIdToEdit: addressId)));
    await refreshPage();
    return false;
  }

  Future<void> addressItemTapCallback(String addressId) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.transparent,
          title: AddressBox(
            addressId: addressId,
          ),
          titlePadding: EdgeInsets.zero,
        );
      },
    );
    await refreshPage();
  }

  Widget buildAddressItemCard(String addressId, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Dismissible(
        key: Key(addressId),
        direction: DismissDirection.horizontal,
        background: buildDismissibleSecondaryBackground(),
        secondaryBackground: buildDismissiblePrimaryBackground(),
        dismissThresholds: {
          DismissDirection.endToStart: 0.65,
          DismissDirection.startToEnd: 0.65,
        },
        child: InkWell(
          child: SizedBox(
            width: double.infinity,
            height: SizeConfig.screenHeight * 0.15,
            child: FutureBuilder<Address>(
              future: UserDatabaseHelper().getAddressFromId(addressId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final address = snapshot.data;
                  // index == 0 ? globaladdresid = addressId : addressId;
                  return Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          decoration: BoxDecoration(
                            color: kTextColor.withOpacity(0.24),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          child: Center(
                              child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Radio(
                                    value: index,
                                    groupValue: selectedradio,
                                    onChanged: (value) {
                                      setState(() {
                                        globaladdresid = addressId;
                                      });
                                      print(globaladdresid);
                                      //print(addresstextid.text);
                                      setselcetedradio(
                                        value,
                                      );
                                      // setState(() {
                                      //   val = value;
                                      // });
                                    },
                                    activeColor: Colors.green,
                                    toggleable: true,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  address.title,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: kTextColor.withOpacity(0.24)),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                address.receiver,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text("City: ${address.phone}"),
                              Text("Phone: ${address.phone}"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  final error = snapshot.error.toString();
                  Logger().e(error);
                }
                return Center(
                  child: Icon(
                    Icons.error,
                    size: 40,
                    color: kTextColor,
                  ),
                );
              },
            ),
          ),
        ),
        // child: AddressShortDetailsCard(
        //   addressId: addressId,
        //   onTap: () async {
        //     //await addressItemTapCallback(addressId);
        //   },
        // ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            final status = await deleteButtonCallback(context, addressId);
            return status;
          } else if (direction == DismissDirection.endToStart) {
            final status = await editButtonCallback(context, addressId);
            return status;
          }
          return false;
        },
        onDismissed: (direction) async {
          await refreshPage();
        },
      ),
    );
  }

  Widget buildDismissiblePrimaryBackground() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
          SizedBox(width: 4),
          Text(
            "Edit",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDismissibleSecondaryBackground() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  const DefaultButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: FlatButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class NothingToShowContainer extends StatelessWidget {
  final String iconPath;
  final String primaryMessage;
  final String secondaryMessage;

  const NothingToShowContainer({
    Key key,
    this.iconPath = "assets/icons/empty_box.svg",
    this.primaryMessage = "Nothing to show",
    this.secondaryMessage = "",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.75,
      height: SizeConfig.screenHeight * 0.2,
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            color: kTextColor,
            width: getProportionateScreenWidth(75),
          ),
          SizedBox(height: 16),
          Text(
            "$primaryMessage",
            style: TextStyle(
              color: kTextColor,
              fontSize: 15,
            ),
          ),
          Text(
            "$secondaryMessage",
            style: TextStyle(
              color: kTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
