object frmPedido: TfrmPedido
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pedido'
  ClientHeight = 299
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 528
    Height = 252
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 7
      Width = 87
      Height = 13
      Caption = 'N'#250'mero do Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowFrame
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 102
      Top = 7
      Width = 38
      Height = 13
      Caption = 'Emiss'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowFrame
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 175
      Top = 7
      Width = 33
      Height = 13
      Caption = 'Cliente'
    end
    object btPesquisarCliente: TSpeedButton
      Left = 218
      Top = 21
      Width = 23
      Height = 23
      Hint = 'Pesquisar Cliente'
      Flat = True
      Glyph.Data = {
        AE060000424DAE06000000000000360000002800000017000000170000000100
        18000000000078060000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        8C867F837E79F8F8F8FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF948E8A574E486E675F756D68FFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF8E87824A423AFFFFFF948D8A362C23FFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9894904A3F39FFFFFFA9A5A1483F38D8D7
        D3FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC
        FCFBD8D6D4C8C9CAD3D2D3F2F0F0FFFFFFFFFFFFFFFFFF544A42D8D5D39A9490
        332A21F8F6F7FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFA09D99524841534B465E534A58504A4A484F8D8C8EFCFCFBE8E8E85F
        564E4940395A514AE5E4E3FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFF4F3F36059535D544CCBC8C6FFFFFFFFE399FFCD6BE0B35F7864
        4349474FC2C0BDC3C0BFF8F5F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFF5C534C807A73FFFFFFFFFFFFFFFFFFFFFFFB
        FFFDF7FFF2D1FFD977B0915648444CF9F9F8FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFABA6A45C534CFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFFDD7C91744A6E6D74FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFEAE8E84F4840D1CD
        CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E4FBC66649
        4648DDDADBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        847D794C423BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFE48C71614EABABB0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFF615851544B44FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFEAA0866B4B96999EFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFF7870694D453EFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFCFFE08079654EA4A4AAFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFD8D6D54A4139DBDA
        D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF51
        4841D4D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFF8E8781746C67FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7
        F1FFFFEEB5B3B7534B46FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFF42372F97918DFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFF6CFAC66403835DADAD8FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFD8D6D53E352C827B77F3
        F1F0FFFFFFFFFFFFFFFFFFFFFFFFA7A4A33B3332B3B0ADFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFF9F9F97B746F4A413968605978726C7068644F463F645B54DDDEDCFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCC9C77D76705F57506F6863B7B4B1FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000}
      ParentShowHint = False
      ShowHint = True
    end
    object lbTotal: TLabel
      Left = 67
      Top = 223
      Width = 390
      Height = 25
      AutoSize = False
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGreen
      Font.Height = -24
      Font.Name = 'DS-Digital'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 7
      Top = 225
      Width = 58
      Height = 13
      Caption = 'Valor Total :'
    end
    object Label5: TLabel
      Left = 252
      Top = 7
      Width = 27
      Height = 13
      Caption = 'Nome'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btIncluir: TButton
      Left = 463
      Top = 55
      Width = 58
      Height = 58
      Caption = '&Incluir'
      TabOrder = 1
      OnClick = btIncluirClick
    end
    object edEmissao: TMaskEdit
      Left = 100
      Top = 22
      Width = 65
      Height = 21
      Enabled = False
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      Text = '  /  /    '
    end
    object edChave: TMaskEdit
      Left = 7
      Top = 22
      Width = 85
      Height = 21
      Enabled = False
      EditMask = '!99999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 4
      Text = '     '
    end
    object edCliente: TMaskEdit
      Left = 173
      Top = 22
      Width = 45
      Height = 21
      EditMask = '!99999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 5
      ParentFont = False
      TabOrder = 0
      Text = '     '
      OnExit = edClienteExit
    end
    object sgPedido: TStringGrid
      Left = 7
      Top = 55
      Width = 450
      Height = 170
      DefaultColWidth = 85
      DefaultRowHeight = 19
      DrawingStyle = gdsGradient
      FixedCols = 0
      RowCount = 2
      TabOrder = 2
      OnKeyDown = sgPedidoKeyDown
      ColWidths = (
        76
        137
        70
        71
        70)
    end
    object edNome: TEdit
      Left = 250
      Top = 22
      Width = 271
      Height = 21
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object btSalvar: TButton
    Left = 380
    Top = 266
    Width = 75
    Height = 25
    Caption = '&Salvar'
    TabOrder = 1
    OnClick = btSalvarClick
  end
  object btCancelar: TButton
    Left = 461
    Top = 266
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    TabOrder = 2
    OnClick = btCancelarClick
  end
  object query_pedido: TFDQuery
    Connection = dm.conexao
    Transaction = transacao
    Left = 8
    Top = 264
  end
  object transacao: TFDTransaction
    Options.DisconnectAction = xdRollback
    Connection = dm.conexao
    Left = 40
    Top = 264
  end
end
