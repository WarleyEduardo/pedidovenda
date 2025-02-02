object FrmClientes: TFrmClientes
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'FrmClientes'
  ClientHeight = 584
  ClientWidth = 1054
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnShow = FormShow
  TextHeight = 15
  object pnTtopo: TPanel
    Left = 0
    Top = 0
    Width = 1054
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 3289650
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 298
      Height = 50
      Align = alClient
      Alignment = taCenter
      Caption = 'Consulta Clientes'
      Color = 3289650
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -37
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object btnFechar: TSpeedButton
      Left = 989
      Top = 0
      Width = 65
      Height = 65
      Cursor = crHandPoint
      Align = alRight
      Caption = ' x'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -37
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btnFecharClick
      ExplicitLeft = 1840
      ExplicitHeight = 49
    end
  end
  object pnRodape: TPanel
    Left = 0
    Top = 495
    Width = 1054
    Height = 89
    Align = alBottom
    BevelOuter = bvNone
    Color = 7434609
    ParentBackground = False
    TabOrder = 1
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 1054
      Height = 9
      Align = alTop
      BevelOuter = bvNone
      Color = 14912079
      ParentBackground = False
      TabOrder = 0
    end
    object ContainerSelecionar: TPanel
      Left = 14
      Top = 20
      Width = 156
      Height = 45
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 2
      Padding.Top = 2
      Padding.Right = 2
      Padding.Bottom = 2
      ParentBackground = False
      TabOrder = 1
      object btnSelecionar: TPanel
        Left = 2
        Top = 2
        Width = 152
        Height = 41
        Cursor = crHandPoint
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Selecionar'
        Color = 8404992
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = btnSelecionarClick
      end
    end
  end
  object pnGrid: TPanel
    Left = 0
    Top = 65
    Width = 1054
    Height = 430
    Align = alClient
    BevelOuter = bvNone
    Color = 14080730
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 2
    object Panel3: TPanel
      Left = 10
      Top = 10
      Width = 1034
      Height = 410
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 10
      Padding.Top = 10
      Padding.Right = 10
      Padding.Bottom = 10
      ParentBackground = False
      TabOrder = 0
      object Panel5: TPanel
        Left = 10
        Top = 10
        Width = 1014
        Height = 63
        Align = alTop
        BevelOuter = bvNone
        Color = 7434609
        Padding.Top = 4
        ParentBackground = False
        TabOrder = 0
        object ContainerConsultar: TPanel
          Left = 850
          Top = 8
          Width = 156
          Height = 45
          BevelOuter = bvNone
          Color = clWhite
          Padding.Left = 2
          Padding.Top = 2
          Padding.Right = 2
          Padding.Bottom = 2
          ParentBackground = False
          TabOrder = 0
          object btnConsultar: TPanel
            Left = 2
            Top = 2
            Width = 152
            Height = 41
            Cursor = crHandPoint
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Consultar'
            Color = 3294597
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -19
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            OnClick = btnConsultarClick
          end
        end
        object edBusca: TEdit
          Left = 203
          Top = 15
          Width = 619
          Height = 29
          TabStop = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object cbBuscar: TComboBox
          Left = 12
          Top = 15
          Width = 161
          Height = 29
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = 'Buscar Por'
          Items.Strings = (
            'C'#243'digo'
            'Nome'
            'Cidade')
        end
      end
      object Panel1: TPanel
        Left = 10
        Top = 73
        Width = 1014
        Height = 327
        Align = alClient
        BevelOuter = bvNone
        Padding.Top = 10
        Padding.Bottom = 10
        TabOrder = 1
        object DBGrid1: TDBGrid
          Left = 0
          Top = 10
          Width = 1014
          Height = 307
          Align = alClient
          DataSource = DataSource1
          DrawingStyle = gdsClassic
          FixedColor = 14912079
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          Options = [dgTitles, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clRed
          TitleFont.Height = -37
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Alignment = taLeftJustify
              Expanded = False
              FieldName = 'codigo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -19
              Font.Name = 'Segoe UI'
              Font.Style = []
              Title.Caption = 'C'#243'digo'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -19
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = [fsBold]
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -19
              Font.Name = 'Segoe UI'
              Font.Style = []
              Title.Caption = 'Nome'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -19
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = [fsBold]
              Width = 423
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -19
              Font.Name = 'Segoe UI'
              Font.Style = []
              Title.Caption = 'Cidade'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -19
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = [fsBold]
              Width = 412
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'uf'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -19
              Font.Name = 'Segoe UI'
              Font.Style = []
              Title.Alignment = taCenter
              Title.Caption = 'UF'
              Title.Font.Charset = DEFAULT_CHARSET
              Title.Font.Color = clWhite
              Title.Font.Height = -19
              Title.Font.Name = 'Segoe UI'
              Title.Font.Style = [fsBold]
              Width = 45
              Visible = True
            end>
        end
      end
    end
  end
  object TableClientes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 426
    Top = 371
    object TableClientescodigo: TIntegerField
      FieldName = 'codigo'
    end
    object TableClientesnome: TStringField
      FieldName = 'nome'
      Size = 30
    end
    object TableClientescidade: TStringField
      FieldName = 'cidade'
      Size = 30
    end
    object TableClientesuf: TStringField
      FieldName = 'uf'
      Size = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = TableClientes
    Left = 580
    Top = 380
  end
end
