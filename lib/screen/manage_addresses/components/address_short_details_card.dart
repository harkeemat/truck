import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:truck/constants.dart';
import 'package:truck/model/Address.dart';
import 'package:truck/service/database/user_database_helper.dart';
import 'package:truck/size_config.dart';

class AddressShortDetailsCard extends StatefulWidget {
  final String addressId;
  final Function onTap;

  const AddressShortDetailsCard(
      {Key key, @required this.addressId, @required this.onTap})
      : super(key: key);

  @override
  _AddressShortDetailsCardState createState() => _AddressShortDetailsCardState(
      addressId: this.addressId, onTap: this.onTap);
}

class _AddressShortDetailsCardState extends State<AddressShortDetailsCard> {
  final String addressId;
  final Function onTap;
  _AddressShortDetailsCardState({this.addressId, this.onTap});
  bool _value = false;
  int val = -1;
  int selectedradio;
  @override
  void initState() {
    super.initState();
    selectedradio = 0;
  }

  setselcetedradio(int val) {
    setState(() {
      selectedradio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        height: SizeConfig.screenHeight * 0.15,
        child: FutureBuilder<Address>(
          future: UserDatabaseHelper().getAddressFromId(widget.addressId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final address = snapshot.data;
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
                                value: 2,
                                groupValue: selectedradio,
                                onChanged: (value) {
                                  setselcetedradio(value);
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
                        border: Border.all(color: kTextColor.withOpacity(0.24)),
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
            } else if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }
}
