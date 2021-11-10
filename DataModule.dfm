object dm: Tdm
  OldCreateOrder = False
  Height = 189
  Width = 215
  object conexao: TFDConnection
    Params.Strings = (
      'Database=dados'
      'User_Name=root'
      'Password=masterkey'
      'DriverID=MySQL')
    TxOptions.DisconnectAction = xdRollback
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'libmysql.dll'
    Left = 112
    Top = 56
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 120
    Top = 8
  end
  object temp_query: TFDQuery
    Connection = conexao
    Left = 24
    Top = 72
  end
end
