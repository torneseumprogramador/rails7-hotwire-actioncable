# frozen_string_literal: true

class InputRedComponent < ViewComponent::Base
    def initialize(form, name)
        @form = form
        @name = name
    end
end
