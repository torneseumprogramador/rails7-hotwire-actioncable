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

Para Rails 7 já vem com o Hotwire integrado, o que torna ainda mais fácil começar a usar o Turbo e o Stimulus. Vamos ver como você pode começar a usá-los no seu aplicativo.

Turbo

O Turbo permite que você crie interações rápidas sem recarregar a página inteira. Ele usa Turbo Frames e Turbo Streams para conseguir isso.

Turbo Frames

Turbo Frames permitem que você atualize uma seção da página sem recarregar todo o conteúdo.

Por exemplo, vamos supor que você tenha uma lista de produtos e um formulário para adicionar um novo produto. Em vez de recarregar toda a página quando um novo produto é adicionado, você pode usar um Turbo Frame para atualizar apenas a lista de produtos.

No seu formulário, você pode adicionar o atributo `data-turbo-frame` para indicar qual seção da página deve ser atualizada.

```erb
<%= turbo_frame_tag 'products' do %>
  <% @products.each do |product| %>
    <%= render product %>
  <% end %>
<% end %>
```

Em seguida, na sua ação `create` do controlador, você pode renderizar o Turbo Frame novamente para atualizar a lista de produtos.

```ruby
def create
  @product = Product.new(product_params)

  if @product.save
    render turbo_stream: turbo_stream.append(:products, partial: 'products/product', locals: { product: @product })
  else
    render :new
  end
end
```

Turbo Streams

Turbo Streams permitem que você envie atualizações para o navegador em tempo real, sem recarregar a página. Isso é feito por meio de WebSockets usando o ActionCable.

Você pode enviar uma atualização Turbo Stream do seu controlador assim:

```ruby
def create
  @message = Message.new(message_params)

  if @message.save
    render turbo_stream: turbo_stream.append(:messages, partial: 'messages/message', locals: { message: @message })
  else
    render :new
  end
end
```

Isso enviará um Turbo Stream para o navegador que adicionará a nova mensagem à lista de mensagens.

Stimulus

O Stimulus é uma pequena biblioteca JavaScript que permite adicionar interatividade ao seu HTML.

Para usar o Stimulus, você precisa adicionar controladores Stimulus ao seu código. Cada controlador Stimulus está associado a um elemento HTML e pode responder a eventos desse elemento.

Por exemplo, você pode criar um controlador Stimulus para lidar com cliques de botões assim:

```javascript
// app/javascript/controllers/button_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log("Button controller connected!")
  }

  click(event) {
    event.preventDefault()
    console.log("Button clicked!")
  }
}
```

Em seguida, você pode associar este controlador a um botão em seu HTML:

```erb
<button data-controller="button" data-action="click->button#click">Click me!</button>
```

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

Um exemplo de um ViewComponent para um input genérico personalizado com classes CSS especiais:

```ruby
# app/components/custom_input_component.rb

class CustomInputComponent < ViewComponent::Base
  def initialize(form:, attribute:, classes: '')
    @form = form
    @attribute = attribute
    @classes = classes
  end

  def call
    content_tag(:div, class: 'custom-input') do
      form.text_field(attribute, class: input_classes)
    end
  end

  private

  attr_reader :form, :attribute, :classes

  def input_classes
    default_classes = 'btn btn-desafio'
    "#{default_classes} #{classes}"
  end
end
```

Neste exemplo, criamos um componente chamado `CustomInputComponent` que recebe três argumentos em seu construtor: `form`, `attribute` e `classes`. O `form` representa o objeto `form_with` que está sendo usado, `attribute` é o atributo do modelo e `classes` são as classes CSS adicionais que você deseja aplicar ao input.

O método `call` é usado para renderizar o componente. Ele envolve o campo de texto (`text_field`) em uma div com a classe CSS `custom-input`. As classes personalizadas são adicionadas ao campo de texto usando o método `input_classes`, que combina as classes padrão com as classes fornecidas no argumento `classes`.

Agora, você pode usar esse componente em suas views. Por exemplo:

```erb
<%= form_with model: @objeto do |form| %>
  <%= render CustomInputComponent.new(form: form, attribute: :nome, classes: 'classe-extra') %>
  <%= form.submit 'Salvar', class: 'btn btn-primary' %>
<% end %>
```

Neste exemplo, estamos usando o componente `CustomInputComponent` para renderizar um campo de texto personalizado. Passamos o objeto `form` e o atributo `:nome` para o componente, juntamente com a classe extra `classe-extra`. Além disso, estamos usando o `form.submit` padrão do Rails para renderizar o botão de envio.

Certifique-se de ajustar o código de acordo com as necessidades específicas do seu projeto, como as classes CSS desejadas e o atributo do modelo a ser usado.
```
