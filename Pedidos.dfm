object frmPedidos: TfrmPedidos
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Pedidos'
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
  OnShow = FormShow
  DesignSize = (
    544
    299)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 528
    Height = 283
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    ExplicitHeight = 264
    DesignSize = (
      528
      283)
    object DBGrid1: TDBGrid
      Left = 7
      Top = 7
      Width = 450
      Height = 268
      Anchors = [akLeft, akTop, akBottom]
      DataSource = ds
      DrawingStyle = gdsGradient
      Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'codigo'
          Title.Alignment = taCenter
          Title.Caption = 'N'#186' Pedido'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'emissao'
          Title.Alignment = taCenter
          Title.Caption = 'Emiss'#227'o'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Alignment = taCenter
          Title.Caption = 'Cliente'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'total'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Total'
          Width = 120
          Visible = True
        end>
    end
    object btIncluir: TButton
      Left = 463
      Top = 7
      Width = 58
      Height = 58
      Caption = '&Incluir'
      TabOrder = 1
      OnClick = btIncluirClick
    end
    object btAlterar: TButton
      Left = 463
      Top = 71
      Width = 58
      Height = 58
      Caption = '&Alterar'
      TabOrder = 2
      OnClick = btAlterarClick
    end
    object btDeletar: TButton
      Left = 463
      Top = 135
      Width = 58
      Height = 58
      Caption = '&Deletar'
      TabOrder = 3
      OnClick = btDeletarClick
    end
  end
  object ds: TDataSource
    DataSet = query
    Left = 41
    Top = 242
  end
  object query: TFDQuery
    Connection = dm.conexao
    SQL.Strings = (
      'select * from pedidos')
    Left = 72
    Top = 242
  end
end
