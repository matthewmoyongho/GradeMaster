// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class ResetPassword extends StatefulWidget {
//   @override
//   State<ResetPassword> createState() => _ResetPasswordState();
// }
//
// class _ResetPasswordState extends State<ResetPassword> {
//   final _formKey = GlobalKey<FormState>();
//   late String _userMail;
//   // void _submit() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     _formKey.currentState!.save();
//   //     showDialog(
//   //         barrierDismissible: false,
//   //         context: context,
//   //         builder: (_) => CircularProgressIndicator());
//   //     try {
//   //       await _auth.sendPasswordResetEmail(_userMail);
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //           content: Text('Password reset email has been sent to your email')));
//   //       Navigator.of(context).popUntil((route) => route.isFirst);
//   //     } on FirebaseAuthException catch (e) {
//   //       ScaffoldMessenger.of(context)
//   //           .showSnackBar(SnackBar(content: Text(e.message.toString())));
//   //       Navigator.of(context).pop();
//   //     }
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: SingleChildScrollView(
//           child: Container(
//             decoration: BoxDecoration(color: Colors.white),
//             child: Container(
//               // height: MediaQuery.of(context).size.height * 0.5,
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height,
//               //color: Color(0xFF006BFF),
//               child: Stack(
//                 fit: StackFit.loose,
//                 clipBehavior: Clip.none,
//                 children: [
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     left: 0,
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     child: Container(
//                       color: Colors.blue[900],
//                       width: double.infinity,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     left: 0,
//                     child: Container(
//                       height: MediaQuery.of(context).size.height,
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(horizontal: 20),
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * 0.6,
//                         decoration: const BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey,
//                                 blurRadius: 5,
//                               )
//                             ]),
//                         child: Center(
//                           child: SingleChildScrollView(
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.fromLTRB(15, 15, 15, 20),
//                               child: Column(
//                                 children: [
//                                   Form(
//                                       key: _formKey,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Reset Password',
//                                             style: TextStyle(
//                                                 fontSize: 30,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           SizedBox(
//                                             height: 40,
//                                           ),
//                                           Text(
//                                             'A password reset link will be sent to your email address',
//                                             style: TextStyle(
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           BlocBuilder<Reset_passwordCubit,
//                                               Reset_passwordState>(
//                                             buildWhen: (previous, current) =>
//                                                 previous != current,
//                                             builder: (context, state) {
//                                               return TextFormField(
//                                                 cursorColor: Colors.blue[900],
//                                                 textInputAction:
//                                                     TextInputAction.next,
//                                                 onChanged: (val) => context
//                                                     .read<Reset_passwordCubit>()
//                                                     .emailChanged(val),
//                                                 // onSaved: (val) =>
//                                                 //     _userMail = val!,
//                                                 keyboardType:
//                                                     TextInputType.emailAddress,
//                                                 decoration: InputDecoration(
//                                                   focusColor: Colors.blue[900],
//                                                   focusedBorder:
//                                                       UnderlineInputBorder(
//                                                           borderSide:
//                                                               BorderSide(
//                                                     color: Colors.blue[900]!,
//                                                     width: 2,
//                                                   )),
//                                                   label: Text(
//                                                     'Email',
//                                                     style: TextStyle(
//                                                         color: Theme.of(context)
//                                                             .primaryColor),
//                                                   ),
//                                                   border: UnderlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                     color: Theme.of(context)
//                                                         .primaryColor,
//                                                     width: 3,
//                                                   )),
//                                                   prefixIcon: Icon(
//                                                       Icons.email_outlined,
//                                                       color: Colors.blue[900]),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                           SizedBox(height: 40),
//                                           BlocBuilder<Reset_passwordCubit,
//                                               Reset_passwordState>(
//                                             builder: (context, state) {
//                                               return GestureDetector(
//                                                 onTap: () {
//                                                   context
//                                                       .read<
//                                                           Reset_passwordCubit>()
//                                                       .resetPassword();
//                                                 },
//                                                 child: Container(
//                                                   child: Text(
//                                                     'Reset Password',
//                                                     style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   width: double.infinity,
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height *
//                                                       0.05,
//                                                   alignment: Alignment.center,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               6),
//                                                       color: Colors.blue[900]),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                           SizedBox(height: 15),
//                                           Container(
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 25),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Expanded(
//                                                     child: Divider(
//                                                   color: Colors.blueGrey,
//                                                 )),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Text('Or'),
//                                                 SizedBox(
//                                                   width: 10,
//                                                 ),
//                                                 Expanded(
//                                                     child: Divider(
//                                                   color: Colors.blueGrey,
//                                                 )),
//                                                 // Text('- - - - - - - - - - - -'),
//                                               ],
//                                             ),
//                                           ),
//                                           SizedBox(height: 15),
//                                           GestureDetector(
//                                             onTap: () =>
//                                                 Navigator.of(context).pop(),
//                                             child: Container(
//                                               child: Text(
//                                                 'Back to login',
//                                                 style: const TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 16,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               width: double.infinity,
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height *
//                                                   0.05,
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   color: Colors.white,
//                                                   border: Border.all(
//                                                       color: Colors.grey,
//                                                       width: 1)),
//                                             ),
//                                           ),
//                                         ],
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
