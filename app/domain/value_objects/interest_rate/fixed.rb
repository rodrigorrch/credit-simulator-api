module Domain
  module ValueObjects
    class InterestRate
      class Fixed < InterestRate
        def initialize(value:)
          super(value: value, type: :fixed)
        end
      end
    end
  end
end
