// Generate the neutral signal sequence (1w, 2w, 3w, ..., 9w, 0w)
List generateNeutralSignalSequence() {
  List neutralSignalSequence = [
    1,
    'w',
    2,
    'w',
    3,
    'w',
    4,
    'w',
    5,
    'w',
    6,
    'w',
    7,
    'w',
    8,
    'w',
    9,
    'w',
    0,
    'w'
  ];
  return neutralSignalSequence;
}

// Function to simulate the combined main color sequence (just as an example)
List<String> generateColorSequence(
    List<String> substanceSignal, List<String> potencySignal) {
  // Combine the substance and potency signals to generate the main sequence
  List<String> combinedSequence = [...potencySignal+substanceSignal];
  print(combinedSequence);
  return combinedSequence;
}
