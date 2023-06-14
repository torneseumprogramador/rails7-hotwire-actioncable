class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[ show edit update destroy ]

  # GET /clientes or /clientes.json
  def index
    @clientes = Cliente.all.limit(2)
  end

  def criar_novo_cliente_hotwire
    # inclui dados na tela
    # render turbo_stream: turbo_stream.append(:cliente_hotwire_id_div, partial: 'clientes/clientes_hotwire', locals: { clientes: Cliente.all.limit(3).order(id: :desc) })

    # substitui dados na tela
    render turbo_stream: turbo_stream.replace(:cliente_hotwire_id_div, partial: 'clientes/clientes_hotwire', locals: { clientes: Cliente.all.limit(3).order(id: :desc) })

    return

    @cliente = Cliente.new({nome: "teste #{Time.now.to_i}", email: "teste #{Time.now.to_i}@gmail.com"})
  
    if @cliente.save
      render turbo_stream: turbo_stream.append(:cliente_hotwire, partial: 'clientes/clientes_hotwire', locals: { clientes: Cliente.all.limit(3).order(id: :desc) })
    else
      render :new
    end
  end
  

  # GET /clientes/1 or /clientes/1.json
  def show
  end

  # GET /clientes/new
  def new
    @cliente = Cliente.new
  end

  # GET /clientes/1/edit
  def edit
  end

  # POST /clientes or /clientes.json
  def create
    @cliente = Cliente.new(cliente_params)

    respond_to do |format|
      if @cliente.save
        format.html { redirect_to cliente_url(@cliente), notice: "Cliente was successfully created." }
        format.json { render :show, status: :created, location: @cliente }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clientes/1 or /clientes/1.json
  def update
    respond_to do |format|
      if @cliente.update(cliente_params)

        turbo_stream = ApplicationController.renderer.render(
          partial: "clientes/tabela",
          locals: { clientes: Cliente.all }
        )
        
        ActionCable.server.broadcast("clientes", turbo_stream)



        format.turbo_stream
        format.html { redirect_to cliente_url(@cliente), notice: "Cliente was successfully updated." }
        format.json { render :show, status: :ok, location: @cliente }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cliente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clientes/1 or /clientes/1.json
  def destroy
    @cliente.destroy

    respond_to do |format|
      format.html { redirect_to clientes_url, notice: "Cliente was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params.require(:cliente).permit(:nome, :email)
    end
end
