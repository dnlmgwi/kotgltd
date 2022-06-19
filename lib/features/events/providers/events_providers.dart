import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kotgltd/features/events/model/kotgEvent.dart';
import 'package:kotgltd/features/events/services/events_repository.dart';
import 'package:kotgltd/features/events/services/reference_generator.dart';
import 'package:kotgltd/packages/dependencies.dart';

final eventsRepoProvider = Provider(
  (ref) => EventsRepository(),
);

final eventsProvider = FutureProvider<KOTGEvent>((ref) async {
  final eventsClient = ref.watch(eventsRepoProvider);
  return eventsClient.fetchEvents();
});

final registeredEventsProvider =
    FutureProvider.family<List?, int>((ref, eventId) async {
  final eventsClient = ref.watch(eventsRepoProvider);
  return eventsClient.registeredEvents(eventID: eventId);
});

final deRegisterEventsProvider = Provider.family((ref, int eventId) async {
  final eventsClient = ref.watch(eventsRepoProvider);
  return eventsClient.deregisterEvent(eventID: eventId);
});

final tcEventsProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
