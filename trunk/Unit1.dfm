object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'WebTCFSC'
  ClientHeight = 140
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object idhtpsrvr1: TIdHTTPServer
    Bindings = <>
    DefaultPort = 8000
    OnCommandGet = idhtpsrvr1CommandGet
    Left = 8
    Top = 8
  end
  object trycn1: TTrayIcon
    PopupMenu = pm1
    Visible = True
    Left = 8
    Top = 104
  end
  object pm1: TPopupMenu
    Left = 8
    Top = 72
    object N1: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N1Click
    end
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 8
    Top = 40
  end
  object con1: TZConnection
    ControlsCodePage = cCP_UTF16
    AutoEncodeStrings = False
    ClientCodepage = 'CL8MSWIN1251'
    Properties.Strings = (
      'controls_cp=CP_UTF16'
      'codepage=CL8MSWIN1251')
    Port = 1521
    Protocol = 'oracle'
    Left = 48
    Top = 8
  end
  object ZQuery1: TZReadOnlyQuery
    Connection = con1
    SQL.Strings = (
      
        'Select f.PUID, v.PWNT_PATH_NAME || '#39'\'#39' || f.PSD_PATH_NAME || '#39'\'#39 +
        ' || f.PFILE_NAME as FILE_PATH,  f.PORIGINAL_FILE_NAME'
      'From infodba.PIMANFILE f'
      'inner join infodba.PIMANVOLUME v on f.RVOLUME_TAGU = v.PUID'
      'where f.PUID = :param1')
    Params = <
      item
        DataType = ftString
        Name = 'param1'
        ParamType = ptInput
        Value = ''
      end>
    Left = 48
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'param1'
        ParamType = ptInput
        Value = ''
      end>
  end
end
