VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TeamKeypad"
   ClientHeight    =   3360
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2400
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3360
   ScaleWidth      =   2400
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "GO !"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   2880
      Width           =   2175
   End
   Begin VB.Frame Frame1 
      Caption         =   "Etat des touches"
      Height          =   2655
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2175
      Begin VB.Timer Timer1 
         Left            =   1080
         Top             =   720
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   11
         Left            =   1320
         Top             =   1920
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   10
         Left            =   840
         Top             =   1920
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   9
         Left            =   360
         Top             =   1920
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   8
         Left            =   1320
         Top             =   1440
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   7
         Left            =   840
         Top             =   1440
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   6
         Left            =   360
         Top             =   1440
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   5
         Left            =   1320
         Top             =   960
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   4
         Left            =   840
         Top             =   960
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   3
         Left            =   360
         Top             =   960
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   2
         Left            =   1320
         Top             =   480
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   1
         Left            =   840
         Top             =   480
         Width           =   495
      End
      Begin VB.Image Image1 
         Height          =   495
         Index           =   0
         Left            =   360
         Top             =   480
         Width           =   495
      End
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   11
      Left            =   4680
      Picture         =   "Form1.frx":08CA
      Top             =   3840
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   10
      Left            =   4200
      Picture         =   "Form1.frx":14AC
      Top             =   3840
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   9
      Left            =   3720
      Picture         =   "Form1.frx":208E
      Top             =   3840
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   8
      Left            =   4680
      Picture         =   "Form1.frx":2C70
      Top             =   3360
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   7
      Left            =   4200
      Picture         =   "Form1.frx":3852
      Top             =   3360
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   6
      Left            =   3720
      Picture         =   "Form1.frx":4434
      Top             =   3360
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   5
      Left            =   4680
      Picture         =   "Form1.frx":5016
      Top             =   2880
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   4
      Left            =   4200
      Picture         =   "Form1.frx":5BF8
      Top             =   2880
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   3
      Left            =   3720
      Picture         =   "Form1.frx":67DA
      Top             =   2880
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   2
      Left            =   4680
      Picture         =   "Form1.frx":73BC
      Top             =   2400
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   1
      Left            =   4200
      Picture         =   "Form1.frx":7F9E
      Top             =   2400
      Width           =   465
   End
   Begin VB.Image Image3 
      Height          =   465
      Index           =   0
      Left            =   3720
      Picture         =   "Form1.frx":8B80
      Top             =   2400
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   11
      Left            =   4680
      Picture         =   "Form1.frx":9762
      Top             =   1680
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   10
      Left            =   4200
      Picture         =   "Form1.frx":A344
      Top             =   1680
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   9
      Left            =   3720
      Picture         =   "Form1.frx":AF26
      Top             =   1680
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   8
      Left            =   4680
      Picture         =   "Form1.frx":BB08
      Top             =   1200
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   7
      Left            =   4200
      Picture         =   "Form1.frx":C6EA
      Top             =   1200
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   6
      Left            =   3720
      Picture         =   "Form1.frx":D2CC
      Top             =   1200
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   5
      Left            =   4680
      Picture         =   "Form1.frx":DEAE
      Top             =   720
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   4
      Left            =   4200
      Picture         =   "Form1.frx":EA90
      Top             =   720
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   3
      Left            =   3720
      Picture         =   "Form1.frx":F672
      Top             =   720
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   2
      Left            =   4680
      Picture         =   "Form1.frx":10254
      Top             =   240
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   1
      Left            =   4200
      Picture         =   "Form1.frx":10E36
      Top             =   240
      Width           =   465
   End
   Begin VB.Image Image2 
      Height          =   465
      Index           =   0
      Left            =   3720
      Picture         =   "Form1.frx":11A18
      Top             =   240
      Width           =   465
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de gestion d'un clavier numérique
' Anthony Rabine pour PC Team 65 Février 2001
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble
'
' Note : ce programme permet d'utiliser un clavier à 12 touches, mais
' il est très facile de l'étendre à un clavier 16 touches en reprenant le
' principe de base.
Dim Data As Integer
Dim Status As Integer
Dim Control As Integer
Dim Touches As Integer
Dim Flag As Boolean
Dim Marche As Boolean

Private Sub Command1_Click()
    ' Arrêt et départ de la scrutation du clavier
    If Marche = True Then
        Timer1.Enabled = True
        Command1.Caption = "STOP"
        Marche = False
    Else
        Timer1.Enabled = False
        Command1.Caption = "GO !"
        Marche = True
    End If
End Sub

Private Sub Form_Load()
    ' Initialisations diverses
    Timer1.Enabled = False
    Timer1.Interval = 100
    Marche = True
    
    'Changez l'adresse du port selon votre configuration
    'Les valeurs usuelles sont &H378, &H278, &H3BC)
    Data = &H378
    Status = Data + 1
    Control = Data + 2
    
    Call RAZ_Touches
End Sub


Private Sub Timer1_Timer()
    ' On scanne les touches
    
    Flag = False ' Détecte si une touche a été appuyée
        
    ' Première colonne à 0V
    Out Control, Inp(Control) Or &H2
    Out Control, Inp(Control) And &HFB
        
    Touches = (Inp(Status)) ' On lit l'état des touches

    Select Case Touches ' Et on affiche celle correspondante
    
    Case 56
        Image1(2) = Image3(2)
        Flag = True
    Case 248
        Image1(5) = Image3(5)
        Flag = True
    Case 88
        Image1(8) = Image3(8)
        Flag = True
    Case 104
        Image1(11) = Image3(11)
        Flag = True
    Case Else
        Call RAZ_Touches
    End Select
    
    If Flag = False Then ' On a rien détecté, on continue de scanner...
    
    ' Deuxième colonne à 0V
    Out Control, Inp(Control) And &HFD
    Out Control, Inp(Control) And &HFB
    
     Touches = (Inp(Status))

    Select Case Touches
    
    Case 56
        Image1(1) = Image3(1)
        Flag = True
    Case 248
        Image1(4) = Image3(4)
        Flag = True
    Case 88
        Image1(7) = Image3(7)
        Flag = True
    Case 104
        Image1(10) = Image3(10)
        Flag = True
    Case Else
        Call RAZ_Touches
    End Select
    
    End If
    
    If Flag = False Then ' On a rien détecté, on continue à scanner...
    
    ' Troisième colonne à 0V
     Out Control, Inp(Control) Or &H6

     Touches = (Inp(Status))

    Select Case Touches
    
    Case 56
        Image1(0) = Image3(0)
        Flag = True
    Case 248
        Image1(3) = Image3(3)
        Flag = True
    Case 88
        Image1(6) = Image3(6)
        Flag = True
    Case 104
        Image1(9) = Image3(9)
        Flag = True
    Case Else
        Call RAZ_Touches
    End Select
    
    End If
  
End Sub

Private Sub RAZ_Touches()
    ' Touches relachées
    Dim i As Integer
    For i = 0 To 11
        Image1(i) = Image2(i)
    Next i
End Sub
