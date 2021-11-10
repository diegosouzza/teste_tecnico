unit Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, biblioteca,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Mask, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  TfrmPedido = class(TForm)
    GroupBox1: TGroupBox;
    btIncluir: TButton;
    btSalvar: TButton;
    btCancelar: TButton;
    Label1: TLabel;
    edEmissao: TMaskEdit;
    Label2: TLabel;
    edChave: TMaskEdit;
    edCliente: TMaskEdit;
    Label3: TLabel;
    btPesquisarCliente: TSpeedButton;
    lbTotal: TLabel;
    Label4: TLabel;
    sgPedido: TStringGrid;
    Label5: TLabel;
    edNome: TEdit;
    query_pedido: TFDQuery;
    transacao: TFDTransaction;
    procedure FormShow(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure sgPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btSalvarClick(Sender: TObject);
    procedure edClienteExit(Sender: TObject);
  private
    acao: TAcao;
    linha, chave: integer;
    executando, cadastrado : boolean;
    function incluir_chave: integer;
    procedure buscar_dados;
    function btCancelar_focado: boolean;
  public
    constructor Create(Aowner: TComponent); reintroduce; overload;
    constructor Create(Aowner: TComponent; v_acao: TAcao; v_linha,v_chave: integer);reintroduce; overload;

    procedure somar;
  end;

var
  frmPedido: TfrmPedido;

implementation

{$R *.dfm}

uses Pedidos, Principal, DataModule, Produto;

function TfrmPedido.btCancelar_focado: boolean;
begin
   result := (ActiveControl = btCancelar);
end;

procedure TfrmPedido.btIncluirClick(Sender: TObject);
begin
   if frmProduto = nil then
      frmProduto := TfrmProduto.Create(self,incluir,0);
   frmProduto.Show;
   Self.Enabled := false;
end;

procedure TfrmPedido.buscar_dados;
var
   i: integer;
begin
   if executando then
      exit;
   executando := true;

   try
      i := 1;
      with frmPedidos.query do
      begin
         edEmissao.Text := FieldByName('emissao').AsString;
         lbTotal.Caption := FloatToStrF(FieldByName('total').AsFloat,ffNumber,15,2);
         edCliente.Text := FieldByName('clientes_codigo').AsString;
         edNome.Text := FieldByName('nome').AsString;
      end;

      with dm.temp_query do
      begin
         close;
         SQL.Clear;
         Open('select pp.*, p.descricao from pedidos_produtos pp left join produtos p on pp.produtos_codigo = p.codigo where pp.pedidos_codigo = '+NumToDados(edChave.Text));

         First;

         while not Eof do
         begin
            if i > 1 then
               sgPedido.RowCount := sgPedido.RowCount + 1;

            sgPedido.Cells[0,i] := FieldByName('produtos_codigo').AsString;
            sgPedido.Cells[1,i] := FieldByName('descricao').AsString;
            sgPedido.Cells[2,i] := FloatToStrF(FieldByName('valor_unitario').AsFloat,ffNumber,15,2);
            sgPedido.Cells[3,i] := FieldByName('quantidade').AsString;
            sgPedido.Cells[4,i] := FloatToStrF(FieldByName('valor_total').AsFloat,ffNumber,15,2);

            inc(i);
            Next;
         end;
         executando := false;
      end;
   except
      on E: Exception do
      begin
         MessageDlg('Erro ao buscar Dados: '+E.Message,mtError,[mbOK],0);
         executando := false;
         close;
      end;
   end;
end;

procedure TfrmPedido.btSalvarClick(Sender: TObject);
var
   i: integer;
begin
   validar_campos(GroupBox1);

   if executando then
      exit;
   executando := true;
   try
      case acao of
         incluir,alterar:
         begin
            if (sgPedido.RowCount = 2) and (trim(sgPedido.Cells[0,1]) = '') then
            begin
               MessageDlg('Inclua ao menos um item',mtWarning,[mbOK],0);
               executando := false;
               exit;
            end;

            with query_pedido do
            begin
               close;

               SQL.Clear;
               ExecSQL('delete from pedidos_produtos where pedidos_codigo = '+NumToDados(edChave.Text));

               close;

               SQL.Clear;
               ExecSQL('update pedidos set total = '+NumToDados(lbTotal.Caption)+',clientes_codigo = '+NumToDados(edCliente.Text)+' where codigo = '+NumToDados(edChave.Text));

               for i := 1 to sgPedido.RowCount-1 do
               begin
                  Close;
                  SQL.Clear;
                  ExecSQL('insert into pedidos_produtos (pedidos_codigo,produtos_codigo,valor_unitario,quantidade,valor_total) '+
                          'values ('+NumToDados(edChave.Text)+','
                                    +NumToDados(sgPedido.Cells[0,i])+','
                                    +NumToDados(sgPedido.Cells[2,i])+','
                                    +NumToDados(sgPedido.Cells[3,i])+','
                                    +NumToDados(sgPedido.Cells[4,i])+')');
               end;

               close;
               cadastrado := true;
            end;

            executando := false;
            close;

         end;
         deletar:
         begin
            if  MessageDlg('Deseja Deletar este Produto?',mtWarning,[mbYes,mbNo],0) = 6 then
            begin
               with query_pedido do
               begin
                  close;

                  SQL.Clear;
                  ExecSQL('delete from pedidos_produtos where pedidos_codigo = '+NumToDados(edChave.Text));

                  close;

                  SQL.Clear;
                  ExecSQL('delete from pedidos where codigo = '+NumToDados(edChave.Text));

                  close;
               end;
            end;

            executando := false;
            Close;
         end;
      end;
   except
      on E:Exception do
      begin
         MessageDlg('Erro ao Salvar pedido',mtError,[mbOK],0);
         executando := false;
         abort;
      end;
   end;
end;

procedure TfrmPedido.btCancelarClick(Sender: TObject);
begin
   close;
end;

constructor TfrmPedido.Create(Aowner: TComponent; v_acao: TAcao;
  v_linha, v_chave: integer);
begin
   inherited Create(AOwner);
   acao  := v_acao;
   linha := v_linha;
   chave := v_chave;
end;

constructor TfrmPedido.Create(Aowner: TComponent);
begin
   inherited Create(AOwner);
end;

procedure TfrmPedido.edClienteExit(Sender: TObject);
begin
   if btCancelar_focado then
      exit;

   if validar_numero(edCliente.Text,inteiro) then
   begin
      edCliente.Text := FloatToStrF(NumToFloat(edCliente.Text),ffNumber,15,0);

      with dm.temp_query do
      begin
         close;
         SQL.Clear;
         Open('select nome from clientes where codigo = '+NumToDados(edCliente.Text));

         if IsEmpty then
         begin
            MessageDlg('O Cliente digitado não está cadastrado.',mtError,[mbOK],0);
            edCliente.SetFocus;
            abort;
         end
         else
            edNome.Text := FieldByName('nome').AsString;
      end;
   end
   else
   begin
      MessageDlg('O Cliente digitado está inválido.',mtError,[mbOK],0);
      edCliente.SetFocus;
      abort;
   end;
end;

procedure TfrmPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if executando then
      exit;

   case acao of
      incluir:
      begin
         if not cadastrado then
         begin
            with query_pedido do
            begin
               close;
               SQL.Clear;
               ExecSQL('delete from pedidos where codigo = '+NumToDados(edChave.Text));
               close;
            end;
         end;
      end;
   end;

   Action := caFree;
   TForm(self.Owner).Enabled := true;
   TfrmPedidos(self.Owner).atualizar_grid;
end;

procedure TfrmPedido.FormDestroy(Sender: TObject);
begin
   if executando then
      exit;

   if frmPedido <> nil then
       frmPedido :=  nil;

   if frmPedidos.cad_pedidos <> nil then
       frmPedidos.cad_pedidos :=  nil;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
   executando := false;
   cadastrado := false;

   sgPedido.Cells[0,0] := 'Cód. Produto';
   sgPedido.Cells[1,0] := 'Descrição';
   sgPedido.Cells[2,0] := 'Val. Unitário';
   sgPedido.Cells[3,0] := 'Quantidade';
   sgPedido.Cells[4,0] := 'Val. Total';

   case acao of
      incluir:
      begin
         edEmissao.Text := DateToStr(now);
         edChave.Text := FloatToStrF(incluir_chave,ffNumber,15,0);
      end;
      alterar:
      begin
         edChave.Text :=  FloatToStrF(chave,ffNumber,15,0);
         buscar_dados;
      end;
      deletar:
      begin
         edChave.Text :=  FloatToStrF(chave,ffNumber,15,0);
         buscar_dados;
         desativar_campos(GroupBox1);
      end;
   end;
end;

function TfrmPedido.incluir_chave: integer;
begin
   if executando then
      exit;
   executando := true;
   try
      with query_pedido do
      begin
         close;
         SQL.Clear;
         ExecSQL('insert into pedidos (emissao) values ('+QuotedStr(FormatDateTime('dd.mm.yyyy',StrToDate(edEmissao.Text)))+')');
         close;
      end;

      with dm.temp_query do
      begin
         close;
         Open('select max(codigo) from pedidos');
         result := Fields[0].AsInteger;
         close;
      end;

      executando :=  false;
   except
      on E:Exception do
      begin
         MessageDlg('Erro ao incluir Chave: '+E.Message,mtError,[mbOK],0);
         executando := false;
         exit;
      end;
   end;
end;

procedure TfrmPedido.sgPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
   begin
      if frmProduto = nil then
         frmProduto := TfrmProduto.Create(self,alterar,sgPedido.Row);
      frmProduto.Show;
   end
   else
   if key = vk_delete then
   begin
      if frmProduto = nil then
         frmProduto := TfrmProduto.Create(self,deletar,sgPedido.Row);
      frmProduto.btSalvar.Caption := '&Deletar';
      frmProduto.Show;
   end;
end;

procedure TfrmPedido.somar;
var
   i: Integer;
   total, total_soma: double;
begin
   total := 0;
   for i := 1 to sgPedido.RowCount-1 do
   begin
      total_soma := (NumToFloat(sgPedido.Cells[2,i])*NumToFloat(sgPedido.Cells[3,i]));
      sgPedido.Cells[4,i] := FloatToStrF(total_soma,ffNumber,15,2);
      total := total + total_soma;
   end;

   lbTotal.Caption := FloatToStrF(total,ffNumber,15,2);
end;

end.
