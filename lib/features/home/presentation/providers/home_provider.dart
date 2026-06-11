export 'package:my_app_forge/features/home/presentation/providers/home_notifier.dart'
    show homeProvider;

/// Provider that exposes the state and notifier for the Home Feature.
///
/// Use `ref.watch(homeProvider)` to listen to the feed data,
/// or `ref.read(homeProvider.notifier)` to execute operations like
/// refresh, pagination, and bookmarking.
const String homeProviderDoc = 'home_provider_doc';
