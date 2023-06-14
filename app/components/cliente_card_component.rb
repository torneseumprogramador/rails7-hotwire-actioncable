# frozen_string_literal: true

class ClienteCardComponent < ViewComponent::Base
    def initialize(cliente:)
        @cliente = cliente
    end
end
