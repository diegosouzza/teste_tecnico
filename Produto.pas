unit Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, biblioteca;

type
  TfrmProduto = class(TForm)
    GroupBox1: TGroupBox;
    btSalvar: TButton;
    btCancelar: TButton;
    Label1: TLabel;
    edProduto: TMaskEdit;
    btPesquisarProduto: TSpeedButton;
    Label2: TLabel;
    edDescricao: TEdit;
    Label3: TLabel;
    edUnitario: TEdit;
    Label4: TLabel;
    edQuantidade: TMaskEdit;
    Label5: TLabel;
    edTotal: TEdit;
    procedure btCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure edUnitarioExit(Sender: TObject);
    procedure edQuantidadeExit(Sender: TObject);
    procedure edProdutoExit(Sender: TObject);
  private
    acao: TAcao;
    linha: integer;
    procedure somar_total;
    function btCancelar_focado: boolean;
  public
    constructor Create(Aowner: TComponent); reintroduce; overload;
    constructor Create(Aowner: TComponent; v_acao: TAcao; v_linha: integer); reintroduce; overload;
  end;

var
  frmProduto: TfrmProduto;

implementation

{$R *.dfm}

uses Pedido, DataModule;

function TfrmProduto.btCancelar_focado: boolean;
begin
   result := (ActiveControl = btCancelar);
end;

procedure TfrmProduto.btSalvarClick(Sender: TObject);
var
   int: integer;
begin
   validar_campos(GroupBox1);
   case acao of
      incluir:
      begin
         with (TForm(Self.Owner) as TfrmPedido) do
         begin
            if (sgPedido.RowCount >= 2) and (trim(sgPedido.Cells[2,1]) <> '') then
               sgPedido.RowCount := sgPedido.RowCount + 1;

            sgPedido.Cells[0,sgPedido.RowCount -1] := trim(edProduto.Text);
            sgPedido.Cells[1,sgPedido.RowCount -1] := trim(edDescricao.Text);
            sgPedido.Cells[2,sgPedido.RowCount -1] := trim(edUnitario.Text);
            sgPedido.Cells[3,sgPedido.RowCount -1] := trim(edQuantidade.Text);
            sgPedido.Cells[4,sgPedido.RowCount -1] := trim(edTotal.Text);
            somar;
         end;
      end;
      alterar:
      begin
         with (TForm(Self.Owner) as TfrmPedido) do
         begin
            sgPedido.Cells[0,linha] := trim(edProduto.Text);
            sgPedido.Cells[1,linha] := trim(edDescricao.Text);
            sgPedido.Cells[2,linha] := trim(edUnitario.Text);
            sgPedido.Cells[3,linha] := trim(edQuantidade.Text);
            sgPedido.Cells[4,linha] := trim(edTotal.Text);
            somar;
         end;
      end;
      deletar:
      begin
         with (TForm(Self.Owner) as TfrmPedido) do
         begin
            if  MessageDlg('Deseja Deletar este Produto?',mtWarning,[mbYes,mbNo],0) = 6 then
            begin
               deletar_linha(sgPedido,linha);
               somar;
            end;
         end;
      end;
   end;
   close;
end;

procedure TfrmProduto.btCancelarClick(Sender: TObject);
begin
   close;
end;

constructor TfrmProduto.Create(Aowner: TComponent; v_acao: TAcao; v_linha: integer);
begin
   inherited Create(AOwner);

   acao  := v_acao;
   linha := v_linha;
end;

constructor TfrmProduto.Create(Aowner: TComponent);
begin
   inherited Create(AOwner);
end;

procedure TfrmProduto.edProdutoExit(Sender: TObject);
var
   temp: integer;
begin
   if btCancelar_focado then
      exit;

   if validar_numero(edProduto.Text,inteiro) then
   begin
      edProduto.Text := FloatToStrF(NumToFloat(edProduto.Text),ffNumber,15,0);

      with dm.temp_query do
      begin
         close;
         SQL.Clear;
         Open('select descricao, valor from produtos where codigo = '+NumToDados(edProduto.Text));

         if IsEmpty then
         begin
            MessageDlg('O Produto digitado não está cadastrado.',mtError,[mbOK],0);
            edProduto.SetFocus;
            abort;
         end
         else
         begin
            edDescricao.Text := FieldByName('descricao').AsString;
            edUnitario.Text := FloatToStrF(FieldByName('valor').AsFloat,ffNumber,15,2);
         end;
      end;
   end
   else
   begin
      MessageDlg('O Cód. Produto digitado está inválido.',mtError,[mbOK],0);
      edProduto.SetFocus;
      abort;
   end;
end;

procedure TfrmProduto.edQuantidadeExit(Sender: TObject);
var
   temp: integer;
begin
   if btCancelar_focado then
      exit;

   if validar_numero(edQuantidade.Text,inteiro) then
   begin
      edQuantidade.Text := FloatToStrF(NumToFloat(edQuantidade.Text),ffNumber,15,0);
      somar_total;
   end
   else
   begin
      MessageDlg('A Quantidade digitada está inválida.',mtError,[mbOK],0);
      edQuantidade.SetFocus;
      abort;
   end;
end;

procedure TfrmProduto.edUnitarioExit(Sender: TObject);
var
   temp: double;
begin
   if btCancelar_focado then
      exit;

   if validar_numero(edUnitario.Text,flutuante) then
   begin
      edUnitario.Text := FloatToStrF(NumToFloat(edUnitario.Text),ffNumber,15,2);
      somar_total;
   end
   else
   begin
      MessageDlg('O Valor Unitário digitado está inválido.',mtError,[mbOK],0);
      edUnitario.SetFocus;
      abort;
   end;
end;

procedure TfrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   TForm(Self.Owner).Enabled :=  true;
end;

procedure TfrmProduto.FormDestroy(Sender: TObject);
begin
   if frmProduto <> nil then
      frmProduto := nil;
end;

procedure TfrmProduto.FormShow(Sender: TObject);
begin
   case acao of
      incluir: habilitar_campos(GroupBox1,1,true);
      alterar:
      begin
         habilitar_campos(GroupBox1,1,false);

         with (TForm(Self.Owner) as TfrmPedido) do
         begin
            edProduto.Text      := sgPedido.Cells[0,linha];
            edDescricao.Text  := sgPedido.Cells[1,linha];
            edUnitario.Text   := sgPedido.Cells[2,linha];
            edQuantidade.Text := sgPedido.Cells[3,linha];
            edTotal.Text      := sgPedido.Cells[4,linha];
         end;
      end;
      deletar:
      begin
         desativar_campos(GroupBox1);

         with (TForm(Self.Owner) as TfrmPedido) do
         begin
            edProduto.Text      := sgPedido.Cells[0,linha];
            edDescricao.Text  := sgPedido.Cells[1,linha];
            edUnitario.Text   := sgPedido.Cells[2,linha];
            edQuantidade.Text := sgPedido.Cells[3,linha];
            edTotal.Text      := sgPedido.Cells[4,linha];
         end;
      end;
   end;
end;

procedure TfrmProduto.somar_total;
begin
   if validar_numero(edQuantidade.Text,inteiro) and validar_numero(edUnitario.Text,flutuante) then
      edTotal.Text := FloatToStrF((NumToFloat(edQuantidade.Text)*NumToFloat(edUnitario.Text)),ffNumber,15,2)
end;

end.
