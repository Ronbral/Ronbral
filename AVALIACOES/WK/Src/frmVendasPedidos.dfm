object frmPedidos: TfrmPedidos
  Left = 0
  Top = 0
  Caption = 'frmPedidos'
  ClientHeight = 543
  ClientWidth = 812
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pBts: TPanel
    Left = 0
    Top = 488
    Width = 812
    Height = 55
    Align = alBottom
    BevelOuter = bvLowered
    Caption = 'pBts'
    ShowCaption = False
    TabOrder = 0
    object Shape1: TShape
      Left = 376
      Top = 11
      Width = 185
      Height = 28
      Brush.Color = 14803425
      Pen.Color = clSilver
      Shape = stRoundRect
    end
    object lTotal: TLabel
      Left = 488
      Top = 17
      Width = 60
      Height = 16
      Alignment = taRightJustify
      Caption = '00000,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 384
      Top = 13
      Width = 24
      Height = 13
      Caption = 'Total'
    end
    object pEncerrar: TPanel
      Left = 626
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
    object btGravarPedido: TButton
      Left = 192
      Top = 16
      Width = 113
      Height = 25
      Caption = 'Gravar Pedido'
      TabOrder = 1
      OnClick = btGravarPedidoClick
    end
    object btCancelarPedido: TButton
      Left = 25
      Top = 16
      Width = 136
      Height = 25
      Caption = 'Cancelar Pedido'
      TabOrder = 2
      OnClick = btCancelarPedidoClick
    end
    object btAtzTotal: TButton
      Left = 567
      Top = 12
      Width = 26
      Height = 25
      Hint = 'Atualizar'
      ImageIndex = 1
      ImageMargins.Left = 2
      Images = dmDb.ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btAtzTotalClick
    end
  end
  object pLancamentos: TPanel
    Left = 0
    Top = 0
    Width = 812
    Height = 216
    Align = alTop
    Caption = 'pLancamentos'
    ShowCaption = False
    TabOrder = 1
    object spInfo: TShape
      Left = 224
      Top = 42
      Width = 577
      Height = 100
      Brush.Color = 15461355
      Pen.Color = 14079702
      Shape = stRoundRect
      Visible = False
    end
    object Label1: TLabel
      Left = 23
      Top = 34
      Width = 84
      Height = 13
      Caption = 'C'#243'digo do Cliente'
    end
    object Label2: TLabel
      Left = 23
      Top = 95
      Width = 89
      Height = 13
      Caption = 'C'#243'digo do Produto'
    end
    object Label3: TLabel
      Left = 24
      Top = 157
      Width = 56
      Height = 13
      Caption = 'Quantidade'
    end
    object Label4: TLabel
      Left = 216
      Top = 157
      Width = 67
      Height = 13
      Caption = 'Pre'#231'o Unit'#225'rio'
    end
    object lCliente: TLabel
      Left = 236
      Top = 54
      Width = 47
      Height = 16
      Caption = 'lCliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lProduto: TLabel
      Left = 236
      Top = 115
      Width = 55
      Height = 16
      Caption = 'lProduto'
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
      Text = 'edCodCliente'
      OnChange = edCodClienteChange
      OnEnter = EditEnter
      OnExit = EditExit
      OnKeyPress = edCodClienteKeyPress
    end
    object edCodProduto: TEdit
      Left = 23
      Top = 114
      Width = 121
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 6
      NumbersOnly = True
      ParentFont = False
      TabOrder = 1
      Text = 'edCodProduto'
      OnEnter = EditEnter
      OnExit = EditExit
      OnKeyPress = edCodProdutoKeyPress
    end
    object edQuant: TEdit
      Left = 24
      Top = 176
      Width = 121
      Height = 21
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 9
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      Text = 'edQuant'
      OnEnter = EditEnter
      OnExit = EditExit
      OnKeyPress = edQuantKeyPress
    end
    object edPrecoUnit: TEdit
      Left = 216
      Top = 176
      Width = 121
      Height = 21
      Alignment = taRightJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      MaxLength = 12
      ParentFont = False
      TabOrder = 3
      Text = 'edPrecoUnit'
      OnEnter = EditEnter
      OnExit = EditExit
      OnKeyPress = edPrecoUnitKeyPress
    end
    object btConsultaCliente: TButton
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
      TabOrder = 4
      OnClick = btConsultaClienteClick
    end
    object btConsultaProduto: TButton
      Left = 150
      Top = 112
      Width = 26
      Height = 25
      Hint = 'Localizar'
      ImageIndex = 0
      ImageMargins.Left = 2
      Images = dmDb.ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btConsultaProdutoClick
    end
    object btAdcProduto: TButton
      Left = 393
      Top = 174
      Width = 125
      Height = 25
      Caption = 'Adicionar Produto'
      TabOrder = 6
      OnClick = btAdcProdutoClick
    end
    object btAbrirPedidos: TButton
      Tag = 1
      Left = 192
      Top = 38
      Width = 26
      Height = 25
      Hint = 'Abrir Pedidos'
      ImageIndex = 2
      ImageMargins.Left = 2
      Images = dmDb.ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btAbrirPedidosClick
    end
    object btExcluirPedido: TButton
      Tag = 2
      Left = 192
      Top = 68
      Width = 26
      Height = 25
      Hint = 'Abrir Pedidos'
      ImageIndex = 3
      ImageMargins.Left = 2
      Images = dmDb.ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = btAbrirPedidosClick
    end
  end
  object dbgPedido: TDBGrid
    Left = 0
    Top = 216
    Width = 812
    Height = 272
    Align = alClient
    DataSource = DS
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnExit = dbgPedidoExit
    Columns = <
      item
        Expanded = False
        FieldName = 'cds_codigo_produto'
        ReadOnly = True
        Title.Caption = 'C'#243'digo do Produto'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cds_descricao'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o do Produto'
        Width = 364
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cds_quantidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        Title.Caption = 'Quantidade'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cds_valor_unitario'
        Title.Caption = 'Vlr. Unit'#225'rio'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cds_valor_total'
        ReadOnly = True
        Title.Caption = 'Vlr.Total'
        Width = 112
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cds_item_editado'
        ReadOnly = True
        Title.Caption = 'EDT'
        Width = 96
        Visible = True
      end>
  end
  object DS: TDataSource
    DataSet = dmDb.cdsProdutos
    Left = 32
    Top = 216
  end
end
