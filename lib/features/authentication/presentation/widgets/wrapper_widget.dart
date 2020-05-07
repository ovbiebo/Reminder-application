import 'package:Reminder/features/authentication/presentation/bloc/bloc.dart';
import 'package:Reminder/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';

///Created by Demilade Oladugba on 4/23/2020

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInFormBloc>(),
      child: SignInPage(),
    );
  }
}
