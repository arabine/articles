VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TestSérie"
   ClientHeight    =   3945
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3495
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3945
   ScaleWidth      =   3495
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame4 
      Caption         =   "Registres"
      Height          =   3015
      Left            =   1440
      TabIndex        =   11
      Top             =   840
      Width           =   1935
      Begin VB.TextBox Text7 
         Height          =   285
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   20
         Text            =   "0"
         Top             =   2520
         Width           =   975
      End
      Begin VB.TextBox Text6 
         Height          =   285
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   19
         Text            =   "0"
         Top             =   2160
         Width           =   975
      End
      Begin VB.TextBox Text5 
         Height          =   285
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   18
         Text            =   "0"
         Top             =   1800
         Width           =   975
      End
      Begin VB.TextBox Text4 
         Height          =   285
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   17
         Text            =   "0"
         Top             =   1440
         Width           =   975
      End
      Begin VB.TextBox Text3 
         Height          =   285
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   16
         Text            =   "0"
         Top             =   1080
         Width           =   975
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   15
         Text            =   "0"
         Top             =   720
         Width           =   975
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   720
         Locked          =   -1  'True
         TabIndex        =   14
         Text            =   "0"
         Top             =   360
         Width           =   975
      End
      Begin VB.Label Label7 
         Caption         =   "MSR"
         Height          =   255
         Left            =   120
         TabIndex        =   25
         Top             =   2520
         Width           =   495
      End
      Begin VB.Label Label6 
         Caption         =   "LSR"
         Height          =   255
         Left            =   120
         TabIndex        =   24
         Top             =   2160
         Width           =   615
      End
      Begin VB.Label Label5 
         Caption         =   "MCR"
         Height          =   255
         Left            =   120
         TabIndex        =   23
         Top             =   1800
         Width           =   495
      End
      Begin VB.Label Label4 
         Caption         =   "LCR"
         Height          =   255
         Left            =   120
         TabIndex        =   22
         Top             =   1440
         Width           =   615
      End
      Begin VB.Label Label3 
         Caption         =   "IIR"
         Height          =   255
         Left            =   120
         TabIndex        =   21
         Top             =   1080
         Width           =   495
      End
      Begin VB.Label Label2 
         Caption         =   "IER"
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   720
         Width           =   495
      End
      Begin VB.Label Label1 
         Caption         =   "Base"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Timer Timer1 
      Left            =   2520
      Top             =   240
   End
   Begin VB.Frame Frame3 
      Caption         =   "Entrées"
      Height          =   1815
      Left            =   120
      TabIndex        =   4
      Top             =   2040
      Width           =   1215
      Begin VB.CheckBox DCD 
         Caption         =   "DCD (1)"
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   1320
         Width           =   975
      End
      Begin VB.CheckBox RI 
         Caption         =   "RI (9)"
         Height          =   375
         Left            =   120
         TabIndex        =   7
         Top             =   960
         Width           =   855
      End
      Begin VB.CheckBox DSR 
         Caption         =   "DSR (6)"
         Height          =   375
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   975
      End
      Begin VB.CheckBox CTS 
         Caption         =   "CTS (8)"
         Height          =   375
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Port"
      Height          =   615
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   1935
      Begin VB.OptionButton COM2 
         Caption         =   "COM2"
         Height          =   255
         Left            =   960
         TabIndex        =   10
         Top             =   240
         Width           =   855
      End
      Begin VB.OptionButton COM1 
         Caption         =   "COM1"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   975
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Sorties"
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Top             =   840
      Width           =   1215
      Begin VB.CheckBox RTS 
         Caption         =   "RTS (7)"
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   600
         Width           =   975
      End
      Begin VB.CheckBox DTR 
         Caption         =   "DTR (4)"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   975
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de gestion d'un clavier numérique
' Anthony Rabine pour PC Team 66 Mars 2001
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble

Dim Base_COM1 As Integer
Dim Base_COM2 As Integer
Dim COMx As Integer
Dim IER As Integer
Dim IER_Value As Integer
Dim IIR As Integer
Dim IIR_Value As Integer
Dim LCR As Integer
Dim LCR_Value As Integer
Dim MCR As Integer
Dim MCR_Value As Integer
Dim LSR As Integer
Dim LSR_Value As Integer
Dim MSR As Integer
Dim MSR_Value As Integer

Private Sub COM1_Click()
    Call Choix_COM
End Sub

Private Sub COM2_Click()
    Call Choix_COM
End Sub

Private Sub Form_Load()
    ' Initialisations diverses
    Timer1.Interval = 100
    
    ' assignation des Registres
    Base_COM1 = &H3F8 ' adresse de base du COM1
    Base_COM2 = &H2F8 ' adresse de base du COM2
    COM2.Value = True
    Call Choix_COM ' On ouvre un port par défaut
    Timer1.Enabled = True
End Sub

Private Sub Choix_COM()
    ' Ici on ouvre le port désigné
    
    Timer1.Enabled = False
    
    If (COM2.Value = True) Then
        COMx = Base_COM2
    Else
        COMx = Base_COM1
    End If
    IER = COMx + 1
    IIR = COMx + 2
    LCR = COMx + 3
    MCR = COMx + 4
    LSR = COMx + 5
    MSR = COMx + 6
    
    ' On ouvre le port correspondant
    Out COMx, 0
    Out LCR, &H80 ' DLAB=1, pour assigner la vitesse de transfert
    Out COM2, &H60 ' 60(hex) = 96(decimal) -> fixe le facteur de division pour avoir 1200 bps
    Out IER, 0 ' Baud rate, bits de poids fort
    Out LCR, &H0 ' DLAB=0
    Out LCR, &H2 ' 7 bits, sans parité, 1 bit de stop (protocole Microsoft Mouse)
    Out IIR, &HC7 ' FIFO Control Register

    Timer1.Enabled = True
End Sub

Private Sub Timer1_Timer()
    
    ' On commence par afficher la valeur de chaque registre
    Text1.Text = Inp(COMx)
    IER_Value = Inp(IER)
    Text2.Text = IER_Value
    IIR_Value = Inp(IIR)
    Text3.Text = IIR_Value
    LCR_Value = Inp(LCR)
    Text4.Text = LCR_Value
    MCR_Value = Inp(MCR)
    Text5.Text = MCR_Value
    LSR_Value = Inp(LSR)
    Text6.Text = LSR_Value
    MSR_Value = Inp(MSR)
    Text7.Text = MSR_Value
        
    ' On en déduit l'état des broches d'entrées (registre MSR)
    If (MSR_Value And &H80) = &H80 Then
        DCD.Value = 1
    Else
        DCD.Value = 0
    End If
    If (MSR_Value And &H40) = &H40 Then
        RI.Value = 1
    Else
        RI.Value = 0
    End If
    If (MSR_Value And &H20) = &H20 Then
        DSR.Value = 1
    Else
        DSR.Value = 0
    End If
    If (MSR_Value And &H10) = &H10 Then
        CTS.Value = 1
    Else
        CTS.Value = 0
    End If
    
    ' On change l'état des sorties selon les cases choisies
     If DTR.Value = 1 Then
        Out MCR, Inp(MCR) Or &H1
    Else
        Out MCR, Inp(MCR) And &HFE
    End If
    
    If RTS.Value = 1 Then
        Out MCR, Inp(MCR) Or &H2
    Else
        Out MCR, Inp(MCR) And &HFD
    End If
    
End Sub
