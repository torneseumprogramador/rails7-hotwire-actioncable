# Hotwire e ViewComponent no Rails 7

Hotwire é uma tecnologia recente introduzida pelo Rails para melhorar a interatividade do usuário, fazendo com que as páginas da web se comportem mais como aplicativos nativos. Hotwire consiste em três componentes principais: Turbo, Stimulus e Strada.

Turbo é o principal componente que acelera a interação com o aplicativo da web, eliminando a necessidade de carregar a página inteira a cada solicitação. Em vez disso, o Turbo carrega apenas as partes da página que mudaram.

Stimulus é uma pequena biblioteca JavaScript que funciona bem com a filosofia Rails de "HTML sobre JS". Em vez de construir grandes aplicações de página única (SPA), você usa o Stimulus para adicionar funcionalidades interativas aos seus templates HTML existentes.

Strada é um componente projetado para melhorar a experiência dos aplicativos móveis construídos com Rails.

## Configurando o Hotwire no Rails 7

1. Adicione as seguintes gems ao seu Gemfile:

   ```ruby
   gem 'hotwire-rails'
   ```

2. Execute `bundle install` para instalar as gems.

3. Instale o Hotwire no seu aplicativo Rails:

   ```bash
   ./bin/rails hotwire:install
   ```

## Trabalhando com Turbo Frames e Turbo Streams

O Turbo Frames permite atualizar partes específicas da página sem recarregar o conteúdo inteiro. Você pode adicionar o Turbo Frames em suas views usando a tag `turbo_frame_tag`.

O Turbo Streams permite enviar atualizações para o navegador em tempo real, sem a necessidade de recarregar a página. Você pode usar `format.turbo_stream` no seu controlador para enviar atualizações Turbo Stream.

## Trabalhando com ViewComponent

O ViewComponent é uma biblioteca que permite criar componentes reutilizáveis para suas views. Você pode adicionar a gem do ViewComponent ao seu Gemfile:

```ruby
gem 'view_component', require: 'view_component/engine'
```

Execute `bundle install` para instalar a gem.

Agora você pode gerar um novo componente usando o gerador fornecido pela gem:

```bash
rails generate component MeuComponente
```

Isso irá gerar os arquivos do componente. Você pode agora editar esses arquivos de acordo com as necessidades do seu projeto.

## Recursos Adicionais

- [Documentação Oficial do Hotwire](https://hotwired.dev/)
- [Documentação Oficial do ViewComponent](https://viewcomponent.org/)

Espero que este tutorial seja útil para você começar a usar o Hotwire e o ViewComponent no Rails 7. Se tiver mais perguntas ou precisar de ajuda adicional, sinta-se à vontade para perguntar!

# Tutorial Completo de Rails 7 com Hotwire e ViewComponent

Este tutorial abrange o uso do Hotwire e ViewComponent no Rails 7, começando do zero até a implementação de componentes e atualizações de página interativas.

## Configurando o Hotwire

No Rails 7, o Hotwire já vem instalado por padrão. Caso esteja usando uma versão anterior, pode adicionar as seguintes gems ao seu Gemfile:

```ruby
gem 'hotwire-rails'
```

Execute \`bundle install\` para instalar as gems.

## Trabalhando com Turbo Frames

Os Turbo Frames permitem que você atualize partes da página sem a necessidade de recarregar toda a página. Para utilizá-los, siga os seguintes passos:

1. Adicione um Turbo Frame à sua página. No exemplo abaixo, criamos um Turbo Frame com a id 'cliente_hotwire_id_div':

```erb
<%= turbo_frame_tag 'cliente_hotwire_id_div' do %>
  <p>Este conteúdo será atualizado.</p>
<% end %>
```

2. Agora você pode criar um link que irá atualizar esse Turbo Frame. Para isso, você precisa adicionar o atributo \`data-turbo-frame\` ao link, fazendo referência à id do Turbo Frame que você deseja atualizar:

```erb
<%= link_to 'Atualizar conteúdo do hotwire', criar_novo_cliente_hotwire_path, data: { turbo_frame: 'cliente_hotwire_id_div' } %>
```

Quando o link é clicado, o Rails vai enviar uma solicitação AJAX para o URL fornecido e vai substituir o conteúdo do Turbo Frame especificado com o conteúdo recebido.

## Trabalhando com ViewComponent

Para trabalhar com ViewComponent, precisamos primeiro instalar a gem. Adicione a seguinte linha ao seu Gemfile:

```ruby
gem 'view_component', require: 'view_component/engine'
```

Execute \`bundle install\` para instalar a gem.

Agora, podemos gerar um novo componente usando o gerador de componentes. Execute o seguinte comando:

```bash
rails generate component ClienteCard
```

Isso irá gerar os arquivos do componente. Você pode agora editar esses arquivos de acordo com as necessidades do seu projeto.

Por exemplo, para um cartão de cliente simples, você poderia ter algo como isto:

```ruby
# app/components/cliente_card_component.rb
class ClienteCardComponent < ViewComponent::Base
  def initialize(cliente:)
    @cliente = cliente
  end
end
```

E a view associada:

```erb
<!-- app/components/cliente_card_component.html.erb -->
<div class="cliente-card">
  <h2><%= @cliente.name %></h2>
  <p><%= @cliente.email %></p>
</div>
```

Você pode renderizar o componente em qualquer view com o seguinte código:

```erb
<%= render ClienteCardComponent.new(cliente: @cliente) %>
```
