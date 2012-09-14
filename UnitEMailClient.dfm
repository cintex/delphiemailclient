object FormEMail: TFormEMail
  Left = 192
  Top = 107
  Width = 460
  Height = 437
  Caption = 'Sutsujs E-Mail Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabelUsername: TLabel
    Left = 24
    Top = 16
    Width = 89
    Height = 16
    Caption = 'Benutzername:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelPass: TLabel
    Left = 24
    Top = 48
    Width = 58
    Height = 16
    Caption = 'Passwort:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelPOP: TLabel
    Left = 24
    Top = 80
    Width = 75
    Height = 16
    Caption = 'POP-Server:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelPort: TLabel
    Left = 288
    Top = 80
    Width = 27
    Height = 16
    Caption = 'Port:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object LabelMailNr: TLabel
    Left = 8
    Top = 368
    Width = 61
    Height = 13
    Caption = 'Mail Nummer'
  end
  object EditUsername: TEdit
    Left = 120
    Top = 16
    Width = 145
    Height = 21
    TabOrder = 0
  end
  object EditPassword: TEdit
    Left = 120
    Top = 48
    Width = 145
    Height = 21
    TabOrder = 1
  end
  object EditPOP: TEdit
    Left = 120
    Top = 80
    Width = 145
    Height = 21
    TabOrder = 2
  end
  object EditPort: TEdit
    Left = 328
    Top = 80
    Width = 73
    Height = 21
    TabOrder = 3
    Text = '110'
  end
  object ButtonConnect: TButton
    Left = 24
    Top = 120
    Width = 113
    Height = 25
    Caption = 'Verbinden'
    TabOrder = 4
    OnClick = ButtonConnectClick
  end
  object ButtonMailList: TButton
    Left = 152
    Top = 120
    Width = 97
    Height = 25
    Caption = 'Liste der Mails'
    TabOrder = 5
  end
  object MemoOutput: TMemo
    Left = 16
    Top = 152
    Width = 409
    Height = 201
    TabOrder = 6
  end
  object EditMailNr: TEdit
    Left = 80
    Top = 368
    Width = 89
    Height = 21
    TabOrder = 7
  end
  object ButtonRead: TButton
    Left = 184
    Top = 368
    Width = 105
    Height = 25
    Caption = 'Mail lesen'
    TabOrder = 8
  end
  object ButtonDeleteMail: TButton
    Left = 304
    Top = 368
    Width = 89
    Height = 25
    Caption = 'Mail löschen'
    TabOrder = 9
  end
  object ButtonUndeleteAll: TButton
    Left = 264
    Top = 120
    Width = 169
    Height = 25
    Caption = 'Löschungen rückgänig machen'
    TabOrder = 10
  end
end
