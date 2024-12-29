String cleanUrl(String url) {
  return url.trim()
      .replaceFirst(RegExp(r'^http://'), '')  // Remove the "http://" prefix
      .replaceFirst(RegExp(r'/$'), '')        // Remove trailing "/"
      .replaceAll('_', ' ');                  // Replace underscores with spaces
}