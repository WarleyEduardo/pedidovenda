object FrmMensagem: TFrmMensagem
  Left = 0
  Top = 0
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'FrmMensagem'
  ClientHeight = 218
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object pnFundo: TPanel
    Left = 0
    Top = 0
    Width = 598
    Height = 218
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnTitulo: TPanel
      Left = 0
      Top = 0
      Width = 598
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Titulo'
      Color = 4079166
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object pnRodape: TPanel
      Left = 0
      Top = 151
      Width = 598
      Height = 67
      Align = alBottom
      Color = 7434609
      ParentBackground = False
      TabOrder = 1
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 596
        Height = 8
        Align = alTop
        BevelOuter = bvNone
        Color = 14912079
        ParentBackground = False
        TabOrder = 2
      end
      object btnCancelar: TBitBtn
        Left = 140
        Top = 15
        Width = 114
        Height = 42
        ParentCustomHint = False
        BiDiMode = bdLeftToRight
        Caption = 'N'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 262312
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnClick = btnCancelarClick
      end
      object btnok: TBitBtn
        Left = 10
        Top = 15
        Width = 114
        Height = 41
        Caption = 'Sim'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnokClick
      end
    end
    object pnCentro: TPanel
      Left = 0
      Top = 41
      Width = 598
      Height = 110
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 4
      Padding.Top = 4
      Padding.Right = 4
      Padding.Bottom = 4
      ParentBackground = False
      TabOrder = 2
      object lbmensagem: TLabel
        Left = 4
        Top = 4
        Width = 590
        Height = 102
        Align = alClient
        Alignment = taCenter
        Caption = 'mensagem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 102
        ExplicitHeight = 30
      end
    end
  end
end
