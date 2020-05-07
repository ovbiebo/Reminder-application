import 'package:Reminder/features/authentication/presentation/bloc/bloc.dart';
import 'package:Reminder/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:Reminder/features/authentication/presentation/widgets/widgets.dart';
import 'package:Reminder/presentation/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../injection.dart';

///Created by Demilade Oladugba on 4/23/2020

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInFormBloc>(),
      child: BlocBuilder<SignInFormBloc, SignInFormState>(
        builder: (context, state) {
          context.bloc<SignInFormBloc>().add(UserChanged());
          if (state.user == null) {
            return SignInPage();
          } else {
            return HomePage();
          }
        },
      ),
    );
  }
}
