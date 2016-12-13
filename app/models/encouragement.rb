# Return some happy or sad encouragement messages

class Encouragement
  class << self
    def negative
      [
        "Let's make next week a great one!",
        "If there are even more next week, I'll squeal.",
      ].sample
    end

    def positive
      [
        "Let's keep it up!",
        'Go team!',
      ].sample
    end
  end
end
