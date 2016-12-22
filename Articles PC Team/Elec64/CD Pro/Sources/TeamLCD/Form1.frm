VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TeamLCD"
   ClientHeight    =   2310
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2790
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2310
   ScaleWidth      =   2790
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command3 
      Caption         =   "Effa&cer"
      Height          =   405
      Left            =   1920
      TabIndex        =   3
      Top             =   1800
      Width           =   735
   End
   Begin VB.TextBox Text2 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1036
         SubFormatType   =   1
      EndProperty
      Height          =   285
      Left            =   1920
      MaxLength       =   2
      TabIndex        =   2
      Text            =   "0"
      Top             =   960
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Ecrire"
      Height          =   405
      Left            =   1920
      TabIndex        =   1
      Top             =   1320
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   120
      MaxLength       =   16
      TabIndex        =   0
      Top             =   480
      Width           =   2535
   End
   Begin VB.Label Label5 
      Caption         =   "Rappel de la position du curseur (16 caractères par ligne) :"
      Height          =   615
      Left            =   120
      TabIndex        =   8
      Top             =   1200
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "Ligne 2 : de 64 à 79"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   2040
      Width           =   1695
   End
   Begin VB.Label Label3 
      Caption         =   "Ligne 1 : de 00 à 15"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1800
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "Position (en décimal)"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   960
      Width           =   2055
   End
   Begin VB.Label Label1 
      Caption         =   "Phrase à écrire (16 caractères max.)"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   2655
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de gestion d'un écran LCD
' Anthony Rabine pour PC Team 64 Janvier 2001
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble
'
' Configuration de l'électronique :
' RS sur pin 17 (/Select In)
' E sur pin 1 (/strobe)
' R/_W à la masse
'
' Attention, logique inversée pour RS et E !
'
'Dernière remarque :
'Si l'afficheur "saute" des lettres, pensez à augmenter le temps
'passé dans la procédure Delay(Temps)

Dim CONTROL As Integer
Dim STATUS As Integer
Dim DATA As Integer

Private Sub Command1_Click()
    Dim Chaine As String
    Dim Position As Integer
    
    Chaine = Text1.Text
    Position = Val(Text2.Text)
    
    'On borne ce que l'utilisateur entre
    If (Position > 15 And Position < 64) Then
        Position = 64
    ElseIf (Position < 0 Or Position > 79) Then
        Position = 0
    End If
    Text2.Text = Position
    
    'Appel de la fonction d'écriture
    Call Ecrire_LCD(Chaine, Position)
End Sub

Private Sub Command3_Click()
    Call Efface_LCD
End Sub

Private Sub Form_Load()
    'Changez l'adresse du port selon votre configuration
    'Les valeurs usuelles sont &H378, &H278, &H3BC)
    DATA = &H378
    STATUS = DATA + 1
    CONTROL = DATA + 2
    Text1.Text = ""
    Text2.Text = 0
    
    'On initialise l'écran au démarrage
    Call Init_LCD
End Sub
Private Sub Efface_LCD()
    Out CONTROL, (&H8 Or Inp(CONTROL))  'RS à 0
    Out DATA, &H1  'Le code pour effacer
    Out CONTROL, (&HFE And Inp(CONTROL)) 'E à 1
    Delay (200)
    Out CONTROL, (&H1 Or Inp(CONTROL)) 'E à 0 pour valider
    Delay (200)
    Out CONTROL, (&HF7 And Inp(CONTROL)) 'RS à 1
End Sub

Private Sub Init_LCD()
    'Initialisation du port parallèle et du LCD
    Dim i As Integer
    Dim Init(3) As Integer
    Init(0) = &HD 'Initialisation de l'affichage
    Init(1) = &H38 '2 lignes, communication sur 8 bits
    Init(2) = &H1 'Efface l'écran
    
    Out CONTROL, &HDF 'Bus de données en sortie
    Out CONTROL, (&H8 Or Inp(CONTROL))  'RS à 0
    
    For i = 0 To 2
        Out DATA, Init(i)  'Paramètre
        Out CONTROL, (&HFE And Inp(CONTROL)) 'E à 1
        Delay (200)
        Out CONTROL, (&H1 Or Inp(CONTROL)) 'E à 0 pour valider
        Delay (200)
    Next i
   
    Out CONTROL, (&HF7 And Inp(CONTROL)) 'RS à 1
End Sub
Private Sub Ecrire_LCD(ByVal Chaine As String, ByVal Position As Integer)
    Dim i As Integer
    Dim Taille As Integer
    Taille = Len(Chaine) 'On calcule le nombre de caractères dans la phrase
    
    'On change l'adresse du curseur dans la DDRAM
    Out CONTROL, (&H8 Or Inp(CONTROL))  'RS à 0
    Out DATA, &H80 + Position 'Paramètre : nouvelle adresse du curseur
    Out CONTROL, (&HFE And Inp(CONTROL)) 'E à 1
    Delay (200)
    Out CONTROL, (&H1 Or Inp(CONTROL)) 'E à 0 pour valider
    Delay (200)

    Out CONTROL, (&HF7 And Inp(CONTROL)) 'on met RS à 1
     For i = 1 To Taille
        Out DATA, Asc(Mid(Chaine, i, 1)) 'on place la donnée sur le bus
        Out CONTROL, (&HFE And Inp(CONTROL)) 'E à 1
        Delay (100)
        Out CONTROL, (&H1 Or Inp(CONTROL)) 'E à 0 pour valider
        Delay (100)
    Next i
End Sub
Private Sub Delay(ByVal Temps As Integer)
    'Fonction perte de temps faite maison, assez bourrine je l'accorde
    'Si vous avez plus joli je suis preneur
    'Si l'afficheur "saute" des lettres (par exemple "Salut" est affiché en "Slt"),
    'augmenter la temporisation passée dans Delay
    Dim i As Long
    Dim j As Long
    For i = 0 To Temps
        For j = 0 To Temps
        Next j
    Next i
End Sub
