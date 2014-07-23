object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 311
  ClientWidth = 643
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
    Left = 160
    Top = 80
  end
  object trycn1: TTrayIcon
    PopupMenu = pm1
    Visible = True
    Left = 384
    Top = 80
  end
  object pm1: TPopupMenu
    Left = 296
    Top = 168
    object N1: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = N1Click
    end
  end
  object tmr1: TTimer
    OnTimer = tmr1Timer
    Left = 320
    Top = 80
  end
end
