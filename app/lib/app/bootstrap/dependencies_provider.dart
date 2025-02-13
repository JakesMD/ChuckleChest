import 'package:cauth_client/cauth_client.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cstorage_client/cstorage_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template CAppDependenciesProvider}
///
/// A widget that injects the application's dependencies into the widget tree.
///
/// {@endtemplate}
class CAppDependenciesProvider extends StatefulWidget {
  /// {@macro CAppDependenciesProvider}
  const CAppDependenciesProvider({required this.builder, super.key});

  /// The child to make the dependencies available to.
  final Widget Function(BuildContext) builder;

  @override
  State<CAppDependenciesProvider> createState() =>
      _CAppDependenciesProviderState();
}

class _CAppDependenciesProviderState extends State<CAppDependenciesProvider> {
  late CChestClient chestClient;
  late CGemClient gemClient;
  late CPlatformClient platformClient;
  late CAuthClient authClient;
  late CPersonClient personClient;
  late CStorageClient storageClient;

  late CAuthRepository authRepository;
  late CChestRepository chestRepository;
  late CGemRepository gemRepository;
  late CPersonRepository personRepository;

  @override
  void initState() {
    super.initState();

    final supabaseClient = Supabase.instance.client;

    final chestsTable = CChestsTable(supabaseClient: supabaseClient);
    final gemsTable = CGemsTable(supabaseClient: supabaseClient);
    final linesTable = CLinesTable(supabaseClient: supabaseClient);
    final peopleTable = CPeopleTable(supabaseClient: supabaseClient);
    final avatarsTable = CAvatarsTable(supabaseClient: supabaseClient);
    final invitationsTable = CInvitationsTable(supabaseClient: supabaseClient);
    final userRolesTable = CUserRolesTable(supabaseClient: supabaseClient);
    final gemShareTokensTable =
        CGemShareTokensTable(supabaseClient: supabaseClient);

    platformClient = CPlatformClient();
    authClient = CAuthClient(authClient: supabaseClient.auth);
    chestClient = CChestClient(
      chestsTable: chestsTable,
      invitationsTable: invitationsTable,
      userRolesTable: userRolesTable,
    );
    gemClient = CGemClient(
      gemsTable: gemsTable,
      linesTable: linesTable,
      gemShareTokensTable: gemShareTokensTable,
    );
    personClient = CPersonClient(
      peopleTable: peopleTable,
      avatarsTable: avatarsTable,
    );
    storageClient = CStorageClient(supabaseClient: supabaseClient);

    authRepository = CAuthRepository(
      authClient: CAuthClient(authClient: supabaseClient.auth),
    );
    chestRepository = CChestRepository(chestClient: chestClient);
    gemRepository = CGemRepository(
      gemClient: gemClient,
      platformClient: platformClient,
    );
    personRepository = CPersonRepository(
      personClient: personClient,
      storageClient: storageClient,
      platformClient: platformClient,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: chestRepository),
        RepositoryProvider.value(value: gemRepository),
        RepositoryProvider.value(value: personRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CCurrentUserCubit(authRepository: authRepository),
          ),
          BlocProvider(create: (_) => CAppSettingsCubit()),
        ],
        child: Builder(builder: widget.builder),
      ),
    );
  }
}
