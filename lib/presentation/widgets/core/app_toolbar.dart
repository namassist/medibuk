import 'package:flutter/material.dart';
import 'package:medibuk/presentation/utils/formatter.dart';
import 'package:medibuk/presentation/widgets/core/app_buttons.dart';

class AppToolbar extends StatelessWidget {
  final String? title;
  final DocumentStatus? status;
  final Function? onRefresh;
  final List<Widget>? actions;

  const AppToolbar({
    super.key,
    this.title,
    this.status,
    this.onRefresh,
    this.actions,
  });

  String _getStatusText(DocumentStatus status) {
    final statusID = getDocumentStatusID(status);

    switch (statusID) {
      case "DR":
        return "Drafted";
      case "IP":
        return "In Progress";
      case "CO":
        return "Completed";
      case "IN":
        return "Invalid";
      case "VO":
        return "Voided";
      default:
        return "";
    }
  }

  Color _getStatusColor(DocumentStatus status, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case DocumentStatus.drafted:
        return colorScheme.primary;
      case DocumentStatus.inprogress:
        return colorScheme.secondary;
      case DocumentStatus.complete:
        return colorScheme.tertiary;
      case DocumentStatus.invalid:
        return colorScheme.error;
      case DocumentStatus.voided:
        return colorScheme.onSurface.withValues(alpha: 0.5);
    }
  }

  IconData _getStatusIcon(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.drafted:
        return Icons.drafts;
      case DocumentStatus.inprogress:
        return Icons.hourglass_empty;
      case DocumentStatus.complete:
        return Icons.check_circle;
      case DocumentStatus.invalid:
        return Icons.error;
      case DocumentStatus.voided:
        return Icons.cancel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const AppTopBar(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.wifi,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    icon: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) =>
                          RotationTransition(turns: animation, child: child),
                      child: Icon(
                        Icons.light_mode_outlined,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        size: 18,
                      ),
                    ),
                    onPressed: () async {},
                    tooltip: "Switch Theme",
                  ),
                ),
                const SizedBox(width: 12),
                if (MediaQuery.of(context).size.width >= 1024)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.8),
                          Theme.of(context).colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.shadow.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 1,
                          height: 20,
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.3),
                                Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.1),
                                Theme.of(
                                  context,
                                ).colorScheme.outline.withValues(alpha: 0.3),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (MediaQuery.of(context).size.width < 1024)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.language,
                                size: 20,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "ID",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        // filteredList = stringList;
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => StatefulBuilder(
                            builder: (context, setStateDialog) => Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: 600,
                                  maxHeight: 600,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .shadow
                                          .withValues(alpha: 0.2),
                                      blurRadius: 20,
                                      offset: Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Header dengan gradient
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(
                                              context,
                                            ).colorScheme.primaryContainer,
                                            Theme.of(context)
                                                .colorScheme
                                                .primaryContainer
                                                .withValues(alpha: 0.7),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add_circle_outline,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryContainer,
                                            size: 20,
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              "Create New",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimaryContainer,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: Icon(
                                              Icons.close,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onPrimaryContainer,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Search Field
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceContainerHighest
                                              .withValues(alpha: 0.5),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline
                                                .withValues(alpha: 0.2),
                                          ),
                                        ),
                                        child: TextField(
                                          autofocus: true,
                                          onChanged: (text) {},
                                          onSubmitted: (text) {
                                            Navigator.pop(context);
                                          },
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                              size: 20,
                                            ),
                                            hintText: "Cari",
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant
                                                      .withValues(alpha: 0.7),
                                                ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 12,
                                                ),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurfaceVariant,
                                              ),
                                        ),
                                      ),
                                    ),

                                    // Results List
                                    // Flexible(
                                    //   child: Container(
                                    //     margin: EdgeInsets.symmetric(
                                    //       horizontal: 20,
                                    //     ),
                                    //     decoration: BoxDecoration(
                                    //       color: Theme.of(context)
                                    //           .colorScheme
                                    //           .onSurfaceVariant
                                    //           .withValues(alpha: 0.3),
                                    //       borderRadius: BorderRadius.circular(
                                    //         12,
                                    //       ),
                                    //     ),
                                    //     child: ListView.builder(
                                    //       shrinkWrap: true,
                                    //       itemCount: filteredList.length,
                                    //       itemBuilder: (context, index) {
                                    //         final text = filteredList.keys
                                    //             .toList()[index];
                                    //         final documentName = filteredList
                                    //             .keys
                                    //             .toList()[index];
                                    //         final singlePage = filteredList
                                    //             .values
                                    //             .toList()[index];

                                    //         return Container(
                                    //           margin: EdgeInsets.symmetric(
                                    //             horizontal: 8,
                                    //             vertical: index == 0 ? 8 : 4,
                                    //           ),
                                    //           decoration: BoxDecoration(
                                    //             color: index == 0
                                    //                 ? Theme.of(context)
                                    //                       .colorScheme
                                    //                       .primary
                                    //                       .withValues(
                                    //                         alpha: 0.1,
                                    //                       )
                                    //                 : Theme.of(
                                    //                     context,
                                    //                   ).colorScheme.surface,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(8),
                                    //             border: index == 0
                                    //                 ? Border.all(
                                    //                     color: Theme.of(context)
                                    //                         .colorScheme
                                    //                         .primary
                                    //                         .withValues(
                                    //                           alpha: 0.3,
                                    //                         ),
                                    //                     width: 1,
                                    //                   )
                                    //                 : null,
                                    //             boxShadow: index == 0
                                    //                 ? [
                                    //                     BoxShadow(
                                    //                       color:
                                    //                           Theme.of(context)
                                    //                               .colorScheme
                                    //                               .primary
                                    //                               .withValues(
                                    //                                 alpha: 0.1,
                                    //                               ),
                                    //                       blurRadius: 4,
                                    //                       offset: Offset(0, 2),
                                    //                     ),
                                    //                   ]
                                    //                 : null,
                                    //           ),
                                    //           child: Material(
                                    //             color: Colors.transparent,
                                    //             child: InkWell(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(8),
                                    //               onTap: () {
                                    //                 Navigator.pop(context);
                                    //               },
                                    //               child: Padding(
                                    //                 padding:
                                    //                     EdgeInsets.symmetric(
                                    //                       horizontal: 16,
                                    //                       vertical: 12,
                                    //                     ),
                                    //                 child: Row(
                                    //                   children: [
                                    //                     if (index == 0)
                                    //                       Container(
                                    //                         width: 4,
                                    //                         height: 20,
                                    //                         decoration: BoxDecoration(
                                    //                           color:
                                    //                               Theme.of(
                                    //                                     context,
                                    //                                   )
                                    //                                   .colorScheme
                                    //                                   .primary,
                                    //                           borderRadius:
                                    //                               BorderRadius.circular(
                                    //                                 2,
                                    //                               ),
                                    //                         ),
                                    //                       ),
                                    //                     if (index == 0)
                                    //                       SizedBox(width: 12),
                                    //                     Expanded(
                                    //                       child: Text(
                                    //                         text,
                                    //                         style: Theme.of(context)
                                    //                             .textTheme
                                    //                             .bodyMedium!
                                    //                             .copyWith(
                                    //                               color:
                                    //                                   index == 0
                                    //                                   ? Theme.of(
                                    //                                       context,
                                    //                                     ).colorScheme.primary
                                    //                                   : Theme.of(
                                    //                                       context,
                                    //                                     ).colorScheme.onSurface,
                                    //                               fontWeight:
                                    //                                   index == 0
                                    //                                   ? FontWeight
                                    //                                         .w500
                                    //                                   : FontWeight
                                    //                                         .normal,
                                    //                             ),
                                    //                       ),
                                    //                     ),
                                    //                     if (index == 0)
                                    //                       Container(
                                    //                         padding:
                                    //                             EdgeInsets.symmetric(
                                    //                               horizontal: 8,
                                    //                               vertical: 4,
                                    //                             ),
                                    //                         decoration: BoxDecoration(
                                    //                           color:
                                    //                               Theme.of(
                                    //                                     context,
                                    //                                   )
                                    //                                   .colorScheme
                                    //                                   .primary
                                    //                                   .withValues(
                                    //                                     alpha:
                                    //                                         0.1,
                                    //                                   ),
                                    //                           borderRadius:
                                    //                               BorderRadius.circular(
                                    //                                 4,
                                    //                               ),
                                    //                         ),
                                    //                         child: Row(
                                    //                           mainAxisSize:
                                    //                               MainAxisSize
                                    //                                   .min,
                                    //                           children: [
                                    //                             Icon(
                                    //                               Icons
                                    //                                   .keyboard_return,
                                    //                               size: 14,
                                    //                               color: Theme.of(
                                    //                                 context,
                                    //                               ).colorScheme.primary,
                                    //                             ),
                                    //                             SizedBox(
                                    //                               width: 4,
                                    //                             ),
                                    //                             Text(
                                    //                               'Enter',
                                    //                               style: Theme.of(context)
                                    //                                   .textTheme
                                    //                                   .bodySmall!
                                    //                                   .copyWith(
                                    //                                     color: Theme.of(
                                    //                                       context,
                                    //                                     ).colorScheme.primary,
                                    //                                     fontSize:
                                    //                                         10,
                                    //                                   ),
                                    //                             ),
                                    //                           ],
                                    //                         ),
                                    //                       ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         );
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width > 600
                              ? 16
                              : 12,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 18,
                            ),
                            if (MediaQuery.of(context).size.width >= 1024) ...[
                              SizedBox(width: 6),
                              Text(
                                "Create New",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ] else ...[
                              SizedBox(width: 4),
                              Text(
                                "Create New",
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: UserProfileDropdown(
                //     username: username,
                //     currentRole: currentRole,
                //     onLogout: () async {
                //       final SharedPreferences pref = await sp;
                //       pref.remove('token');
                //       await _authBloc.logOut();
                //       Navigator.popUntil(context, (route) => route.isFirst);
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(builder: (context) => LoginPage()),
                //       );
                //     },
                //     onChangeRole: () async {
                //       final _httpReqUtil = getIt<HttpRequestUtil>();
                //       final SharedPreferences pref = await sp;
                //       final String jsonString =
                //           pref.getString('login_cred') ?? '';
                //       LoginCredentialMedibook? cred;
                //       final Map<String, dynamic> jsonMap = jsonDecode(
                //         jsonString,
                //       );
                //       cred = LoginCredentialMedibook.fromJson(jsonMap);
                //       await _httpReqUtil.setAuthHeader(token: cred.token);
                //       Navigator.popUntil(context, (route) => route.isFirst);
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) =>
                //               LoginRolesPage(loginCredentialMedibook: cred!),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (title != null)
            Material(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SelectableText(
                                title!,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                    ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (onRefresh != null)
                                    AppButton(
                                      icon: Icons.refresh,
                                      width: 100,
                                      text: '',
                                      onPressed: () {
                                        onRefresh!();
                                      },
                                    ),
                                  SizedBox(width: 8),
                                  if (status != null) ...[
                                    SizedBox(width: 4),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(
                                          status!,
                                          context,
                                        ).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getStatusIcon(status!),
                                            color: _getStatusColor(
                                              status!,
                                              context,
                                            ),
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            _getStatusText(status!),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: _getStatusColor(
                                                status!,
                                                context,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width > 600)
                              ? 32
                              : 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          if (actions != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(children: actions!),
            ),
        ],
      ),
    );
  }
}
