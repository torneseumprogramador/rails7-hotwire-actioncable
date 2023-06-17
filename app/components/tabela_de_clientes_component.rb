# frozen_string_literal: true

class TabelaDeClientesComponent < ViewComponent::Base
    def initialize(clientes)
        @clientes = clientes
    end
end
