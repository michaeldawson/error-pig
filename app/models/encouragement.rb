# Return some happy or sad encouragement messages

class Encouragement
  class << self
    def negative
      [
        "Let's make next week a great one!",
        'Oink.',
      ].sample
    end

    def positive
      [
        "Let's keep it up!",
        'Go team!',
        'Huzzah!',
        'Oink.',
      ].sample
    end
  end
end
