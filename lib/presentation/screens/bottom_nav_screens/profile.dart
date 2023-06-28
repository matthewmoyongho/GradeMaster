import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logic/gp_course/gp_course_bloc.dart';
import '../../../../business_logic/gp_course/gp_course_state.dart';
import '../../../../business_logic/user/user_cubit.dart';
import '../../../../business_logic/user/user_state.dart';
import '../../widgets/app_drawer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool readOnly = true;
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? email;
  String? username;
  String? gpTarget;
  String? school;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //  setData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final user = FirebaseAuth.instance.currentUser;
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: const Text('Exit app?'),
                      content: const Text('Press \'OK\' to confirm'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('OK')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Cancel')),
                      ],
                    )) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          elevation: 0,
          title: const Text('Profile'),
          actions: [
            if (readOnly)
              IconButton(
                  onPressed: () {
                    setState(() {
                      readOnly = !readOnly;
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            if (!readOnly)
              IntrinsicHeight(
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        UserData userData = UserData(
                            school: school, phone: phone, gpTarget: gpTarget);

                        BlocProvider.of<UserCubit>(context, listen: false)
                            .updateUserData(userData);
                        setState(() {
                          readOnly = !readOnly;
                        });
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.white70,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          readOnly = !readOnly;
                        });
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        drawer: AppDrawer(),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            phone = state.phone ?? '';
            email = user!.email ?? '';
            username = user.displayName ?? '';
            gpTarget = state.gpTarget ?? '';
            school = state.school ?? '';
            return ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
                  height: deviceSize.height * 0.28,
                  decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          user.photoURL == null
                              ? CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.blueGrey,
                                  child: Text(
                                    (state.name)!.substring(0, 1),
                                    style: const TextStyle(fontSize: 50),
                                  ),
                                )
                              : Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/app_icon3.png'),
                                      image: NetworkImage(user.photoURL!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          BlocBuilder<GPCourseBloc, GPCourseState>(
                            builder: (context, GPState) {
                              if (GPState is GPCourseLoaded) {
                                return Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: deviceSize.width * .55,
                                      child: FittedBox(
                                        child: Text(
                                          state.name!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${double.parse(GPState.cgpa).isNaN ? '' : GPState.cgpa} - ${GPState.degree}',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      GPState.diploma,
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: deviceSize.height * 0.58,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PHONE NO:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blueGrey),
                        ),

                        TextFormField(
                          maxLength: 11,
                          readOnly: readOnly,
                          initialValue: phone ?? '',
                          style: const TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blueGrey,
                              width: 3,
                            )),
                          ),
                          onSaved: (val) {
                            setState(() {
                              phone = val!;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Email Address
                        const Text(
                          'EMAIL ADDRESS:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blueGrey),
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: email ?? '',
                          style: const TextStyle(fontSize: 18),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blueGrey,
                              width: 3,
                            )),
                          ),
                          onSaved: (val) {
                            email = val!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Birth Info
                        const Text(
                          'USERNAME:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blueGrey),
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: username ?? '',
                          style: const TextStyle(fontSize: 18),
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blueGrey,
                              width: 3,
                            )),
                          ),
                          onSaved: (val) {
                            username = val!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //Target gp
                        const Text(
                          'TARGET GP:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blueGrey),
                        ),
                        TextFormField(
                          readOnly: readOnly,
                          initialValue: gpTarget ?? '',
                          style: const TextStyle(fontSize: 18),
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blueGrey,
                              width: 3,
                            )),
                          ),
                          onSaved: (val) {
                            gpTarget = val!;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //School Info
                        const Text(
                          'SCHOOL:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.blueGrey),
                        ),
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          readOnly: readOnly,
                          initialValue: school ?? '',
                          style: const TextStyle(fontSize: 18),
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.blueGrey,
                              width: 3,
                            )),
                          ),
                          onSaved: (val) {
                            school = val!;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
