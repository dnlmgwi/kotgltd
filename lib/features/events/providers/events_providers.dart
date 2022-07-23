import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kotgltd/features/events/model/kotgEvent.dart';
import 'package:kotgltd/features/events/services/events_repository.dart';
import 'package:kotgltd/features/profile/providers/profile_providers.dart';
import 'package:kotgltd/packages/dependencies.dart';

final eventsRepoProvider = Provider(
  (ref) => EventsRepository(),
);

final eventsProvider = FutureProvider<KOTGEvent>((ref) async {
  final eventsClient = ref.watch(eventsRepoProvider);
  return eventsClient.fetchEvents();
});

final userEventsProvider = FutureProvider((ref) async {
  final eventsClient = ref.watch(eventsRepoProvider);
  return eventsClient.userEvents();
});

final ticketProvider =
    FutureProvider.family.autoDispose((ref, int eventId) async {
  final eventsClient = ref.watch(eventsRepoProvider);
  return eventsClient.ticketDetails(eventId: eventId);
});

final userPayProvider = FutureProvider.family((ref, String reference) async {
  var phoneNumber = ref.read(paymentPhoneNumberProvider.state).state;

  final eventsClient = ref.watch(eventsRepoProvider);

  return eventsClient.ticketPay(reference: reference, phoneNumber: phoneNumber);
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
