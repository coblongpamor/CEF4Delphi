object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'qwerty'
  ClientHeight = 624
  ClientWidth = 1038
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDefault
  Visible = True
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object CEFWindowParent1: TCEFWindowParent
    Left = 0
    Top = 0
    Width = 1038
    Height = 444
    Align = alClient
    TabStop = True
    TabOrder = 0
  end
  object TouchKeyboard1: TTouchKeyboard
    Left = 0
    Top = 444
    Width = 1038
    Height = 180
    Align = alBottom
    GradientEnd = clSilver
    GradientStart = clGray
    Layout = 'Standard'
    Visible = False
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 300
    OnTimer = Timer1Timer
    Left = 56
    Top = 88
  end
  object Chromium1: TChromium
    OnCanFocus = Chromium1CanFocus
    OnProcessMessageReceived = Chromium1ProcessMessageReceived
    OnBeforeContextMenu = Chromium1BeforeContextMenu
    OnContextMenuCommand = Chromium1ContextMenuCommand
    OnPreKeyEvent = Chromium1PreKeyEvent
    OnKeyEvent = Chromium1KeyEvent
    OnBeforePopup = Chromium1BeforePopup
    OnAfterCreated = Chromium1AfterCreated
    OnBeforeClose = Chromium1BeforeClose
    OnOpenUrlFromTab = Chromium1OpenUrlFromTab
    Left = 56
    Top = 152
  end
end
