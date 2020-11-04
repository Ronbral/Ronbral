object frmConsultas: TfrmConsultas
  Left = 0
  Top = 0
  Caption = 'frmConsultas'
  ClientHeight = 507
  ClientWidth = 899
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pBts: TPanel
    Left = 0
    Top = 452
    Width = 899
    Height = 55
    Align = alBottom
    BevelOuter = bvLowered
    Caption = 'pBts'
    ShowCaption = False
    TabOrder = 0
    object pEncerrar: TPanel
      Left = 713
      Top = 1
      Width = 185
      Height = 53
      Align = alRight
      Caption = 'pEncerrar'
      ShowCaption = False
      TabOrder = 0
      object btEncerrar: TButton
        Left = 61
        Top = 12
        Width = 99
        Height = 25
        Caption = 'Encerrar'
        TabOrder = 0
        OnClick = btEncerrarClick
      end
    end
    object btExcluirPedido: TButton
      Left = 25
      Top = 16
      Width = 151
      Height = 25
      Caption = 'Excluir Pedido'
      TabOrder = 1
      OnClick = btExcluirPedidoClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 899
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 23
      Top = 34
      Width = 87
      Height = 13
      Caption = 'N'#250'mero do Pedido'
    end
    object Label2: TLabel
      Left = 16
      Top = 107
      Width = 44
      Height = 16
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edCodCliente: TEdit
      Left = 23
      Top = 53
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 10
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      Text = 'edNumPedido'
      OnEnter = edCodClienteEnter
      OnExit = edCodClienteExit
    end
    object btConsultaPedido: TButton
      Left = 150
      Top = 51
      Width = 26
      Height = 25
      Hint = 'Localizar'
      ImageIndex = 0
      ImageMargins.Left = 2
      Images = dmDb.ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btConsultaPedidoClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 129
    Width = 899
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    object Label3: TLabel
      Left = 16
      Top = 89
      Width = 43
      Height = 16
      Caption = 'Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbgPedido: TDBGrid
      Left = 0
      Top = 0
      Width = 899
      Height = 72
      Align = alTop
      DataSource = DSPedido
      Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'cds_tcl_codigo'
          Title.Caption = 'C'#243'digo'
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cds_tcl_nome'
          Title.Caption = 'Nome'
          Width = 324
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cds_tcl_cidade'
          Title.Caption = 'Cidade'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cds_tcl_uf'
          Title.Caption = 'UF'
          Visible = True
        end>
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 353
    Width = 899
    Height = 99
    Align = alClient
    DataSource = DS
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'tpd_codigo'
        Title.Caption = 'C'#243'digo'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tpd_descricao'
        Title.Caption = 'Descri'#231#227'o'
        Width = 332
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tpp_quantidade'
        Title.Caption = 'Quantidade'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tpp_valor_unitario'
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tpp_valor_total'
        Title.Caption = 'Valor Total'
        Width = 124
        Visible = True
      end>
  end
  object Panel3: TPanel
    Left = 0
    Top = 241
    Width = 899
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 4
    object Label4: TLabel
      Left = 16
      Top = 90
      Width = 126
      Height = 16
      Caption = 'Produtos do Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGrid2: TDBGrid
      Left = 0
      Top = 0
      Width = 899
      Height = 72
      Align = alTop
      DataSource = DSPedido
      Options = [dgEditing, dgTitles, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'cds_tdg_pedido_numero'
          Title.Caption = 'N'#250'mero Pedido'
          Width = 112
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cds_tdg_data_emissao'
          Title.Caption = 'Data Emiss'#227'o'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cds_tdg_valor_total'
          Title.Caption = 'Valor Total'
          Width = 124
          Visible = True
        end>
    end
  end
  object DS: TDataSource
    Left = 32
    Top = 216
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 40
    object cdsPedidocds_tcl_codigo: TLargeintField
      FieldName = 'cds_tcl_codigo'
    end
    object cdsPedidocds_tcl_nome: TStringField
      FieldName = 'cds_tcl_nome'
      Size = 100
    end
    object cdsPedidocds_tcl_cidade: TStringField
      FieldName = 'cds_tcl_cidade'
      Size = 50
    end
    object cdsPedidocds_tcl_uf: TStringField
      FieldName = 'cds_tcl_uf'
      Size = 2
    end
    object cdsPedidocds_tdg_pedido_numero: TLargeintField
      FieldName = 'cds_tdg_pedido_numero'
    end
    object cdsPedidocds_tdg_data_emissao: TDateTimeField
      FieldName = 'cds_tdg_data_emissao'
    end
    object cdsPedidocds_tdg_valor_total: TCurrencyField
      FieldName = 'cds_tdg_valor_total'
    end
  end
  object DSPedido: TDataSource
    DataSet = cdsPedido
    Left = 344
    Top = 40
  end
end
