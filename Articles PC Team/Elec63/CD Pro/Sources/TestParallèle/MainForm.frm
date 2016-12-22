VERSION 5.00
Begin VB.Form MainForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Test du port parallèle"
   ClientHeight    =   1680
   ClientLeft      =   900
   ClientTop       =   1395
   ClientWidth     =   3360
   Icon            =   "MainForm.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1680
   ScaleWidth      =   3360
   Begin VB.Frame Frame1 
      Caption         =   "Valeur des registres"
      Height          =   1455
      Left            =   1560
      TabIndex        =   3
      Top             =   120
      Width           =   1695
      Begin VB.Timer Timer1 
         Left            =   120
         Top             =   240
      End
      Begin VB.Label Label3 
         Caption         =   "0"
         Height          =   255
         Left            =   1200
         TabIndex        =   11
         Top             =   1080
         Width           =   375
      End
      Begin VB.Label Label2 
         Caption         =   "0"
         Height          =   255
         Left            =   1200
         TabIndex        =   10
         Top             =   720
         Width           =   375
      End
      Begin VB.Label Label1 
         Caption         =   "0"
         Height          =   255
         Left            =   1200
         TabIndex        =   7
         Top             =   360
         Width           =   375
      End
      Begin VB.Label Label6 
         Caption         =   "Etat"
         Height          =   255
         Left            =   240
         TabIndex        =   6
         Top             =   720
         Width           =   855
      End
      Begin VB.Label Label5 
         Caption         =   "Contrôle"
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   1080
         Width           =   855
      End
      Begin VB.Label Label4 
         Caption         =   "Données"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   360
         Width           =   735
      End
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "MainForm.frx":08CA
      Left            =   120
      List            =   "MainForm.frx":08D7
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   480
      Width           =   1335
   End
   Begin VB.TextBox Text1 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1036
         SubFormatType   =   1
      EndProperty
      Height          =   315
      Left            =   120
      MaxLength       =   3
      TabIndex        =   1
      Text            =   "0"
      Top             =   1200
      Width           =   375
   End
   Begin VB.CommandButton cmdWriteToPort 
      Caption         =   "Ecrire"
      Height          =   375
      Left            =   600
      TabIndex        =   0
      Top             =   1200
      Width           =   855
   End
   Begin VB.Label Label7 
      Caption         =   "Choix du registre"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label Label8 
      Caption         =   "Valeur à écrire"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   840
      Width           =   1335
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de test du port parallèle
' Anthony Rabine
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble

Option Explicit
Dim Value As Integer
Dim BaseAddress As Integer
Dim PortAddress As Integer
Private Sub Combo1_Click()
    'On change l'adresse selon le choix de l'utilisateur
    Select Case Combo1.ListIndex
        Case 0
            PortAddress = BaseAddress       'Données
        Case 1
            PortAddress = BaseAddress + 1   'Etat
        Case 2
            PortAddress = BaseAddress + 2   'Contrôle
    End Select
    End Sub
Private Sub cmdWriteToPort_Click()
'On lit la valeur ...
Value = Val(Text1.Text)
If (Value > 255 Or Value < 0) Then
    Value = 0
    Text1.Text = Value
End If
'...et on l'écrit sur le port
Out PortAddress, Value
End Sub
Private Sub Form_Load()
'Initialisations
Combo1.ListIndex = 0
Value = 0
Text1.Text = 0
'Changez l'adresse du port si besoin
'Les valeurs usuelles sont &H378, &H278, &H3BC)
BaseAddress = &H378
PortAddress = BaseAddress

'On va lire les registres toutes les 100 ms
Timer1.Interval = 100
Timer1.Enabled = True
End Sub

Private Sub Timer1_Timer()
    Call ReadPorts
End Sub
Private Sub ReadPorts()
    'On affiche la valeur des 3 registres
    Label1.Caption = Inp(BaseAddress)
    Label2.Caption = Inp(BaseAddress + 1)
    Label3.Caption = Inp(BaseAddress + 2)
End Sub
