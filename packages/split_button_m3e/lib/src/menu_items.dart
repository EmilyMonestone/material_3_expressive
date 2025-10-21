/// Simple generic menu item model for SplitButtonM3E.
class SplitButtonM3EItem<T> {
  const SplitButtonM3EItem({
    required this.value,
    required this.child,
    this.enabled = true,
  });

  final T value;
  final Object child; // Widget or plain string; the caller builds PopupMenuItem
  final bool enabled;
}
