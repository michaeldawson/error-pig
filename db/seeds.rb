# rubocop:disable Metrics/LineLength
facts = [
  'If you’ve ever suggested that someone was ‘sweating like a pig’, then you’d be wrong. Pigs have hardly any sweat glands, and one of the best ways for them to cool down is to wallow in all of that glorious mud.',
  "A pig's squeal can be as loud as 115 decibels – that’s 3 decibels higher than the sound of a supersonic airliner.",
  "Adult pigs can run a mile in seven minutes. Bet YOU can't run a mile in seven minutes.",
  'The noble pig is associated with fertility and virility in China. This has led to statues of pigs being displayed prominently in the bedrooms of Chinese couples who are trying to have children.',
  'On the uninhabited Bahaman Island of Big Major Cay, a population of wild aquatic pigs rules the island, and many have taken to swimming out to the boats offshore in the hope of being rewarded with a tasty snack.',
  'Pigs are curious and insightful animals who are widely accepted as being smarter than young children of at least 3 years of age.',
  'My favourite movie is the documentary, _Babe_.',
  "Domestic pigs have curly tails; wild pigs have straight tails. Personally, I style mine depending on how I'm feeling on the day.",
  'In the medical industry, pig hearts are often used as replacements for human hearts.',
  '"A pig in the poke" comes from a common trick in 17th-century England of trying to give away a cat to an unsuspecting "shopper" for a suckling pig (a young pig). When the buyer opened the poke (sack), he "let the cat out of the bag," and the trick was revealed.',
  'The Spanish explorer Hernando DeSoto brought the first pigs to the New World in 1539. A true hero.',
]

facts.each { |fact| PiggyFact.create!(fact: fact) }
