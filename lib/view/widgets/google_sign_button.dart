import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final void Function()? onPress;
   const GoogleSignInButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
              children: [
                    const Expanded(child: Divider(thickness: 2,color: Colors.black,)),
                    const Text('أو من خلال',style: TextStyle(fontWeight: FontWeight.bold),),
                    const Expanded(child: Divider(thickness: 2,color: Colors.black,))
                       ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
        Container(
                            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 3, 28, 66).withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
                            child: ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey.shade50)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Sign In with Google',style: TextStyle(color: Color.fromARGB(255, 3, 28, 66),fontSize: 16),),
                                  Image.asset('assets/google.png')
                                  
                                ],
                              ),
                              onPressed: () {
                                onPress;
                              },
                            ),
                          ),
      ],
    );
  }

}