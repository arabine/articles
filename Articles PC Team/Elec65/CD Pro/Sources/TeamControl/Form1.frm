VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TeamControl"
   ClientHeight    =   1755
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2235
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1755
   ScaleWidth      =   2235
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   240
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   960
      Width           =   1695
   End
   Begin VB.Timer Timer1 
      Left            =   840
      Top             =   480
   End
   Begin VB.CommandButton Command1 
      Caption         =   "I&nit"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   1320
      Width           =   1695
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
      Left            =   1200
      Locked          =   -1  'True
      MaxLength       =   4
      TabIndex        =   1
      Top             =   480
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   240
      Locked          =   -1  'True
      MaxLength       =   4
      TabIndex        =   0
      Top             =   480
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "Code saisi :"
      Height          =   255
      Left            =   1200
      TabIndex        =   4
      Top             =   120
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Code réel :"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de gestion d'un écran LCD et d'un clavier
' Anthony Rabine pour PC Team 65 Février 2001
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble
'
' Configuration de l'électronique :
' RS sur pin 17 (/Select In)
' E sur pin 1 (/strobe)
' R/_W à la masse
' Attention, logique inversée pour RS, E, Busy et Autofeed !
' Clavier 12 touches, facilement extensible à 16 touches

Dim CONTROL As Integer
Dim STATUS As Integer
Dim DATA As Integer
Dim Touches As Integer
Dim Flag As Boolean
Dim Nb_chiffres As Integer
Dim Code_Saisi As String
Dim Code_Reel As String
Dim Actif As String

Private Sub Command1_Click()
    ' On (re-) initialise la procédure de saisi du code
    
    Code_Reel = Int(Rnd() * 9999) + 1 ' Code au hasard
    Text1.Text = Code_Reel
    Code_Saisi = ""
    Text2.Text = Code_Saisi
    Text3.Text = "Attente code..."
    Nb_chiffres = 0
    Call Ecrire_LCD("Entrez le code", 0)
    Call Ecrire_LCD("    ", 64) ' On efface la deuxième ligne
    Call Ecrire_LCD("", 64) ' On place le curseur en ligne 2
    Timer1.Enabled = True ' On scrute le clavier
End Sub

Private Sub Form_Load()
    ' Initialisations diverses
    Timer1.Enabled = False
    Timer1.Interval = 100 ' On scanne les touches toutes les 100 millisecondes
    Randomize ' Initialisation du générateur aléatoire
    
    'Changez l'adresse du port selon votre configuration
    'Les valeurs usuelles sont &H378, &H278, &H3BC)
    DATA = &H378
    STATUS = DATA + 1
    CONTROL = DATA + 2
    
    'On initialise tout
    Call Init_LCD
    Call Command1_Click
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

Private Sub Timer1_Timer()
    ' Procédure de scannage les touches
    
    Flag = False ' Détecte si une touche a été appuyée
        
    ' Première colonne à 0V
    Out CONTROL, Inp(CONTROL) Or &H2
    Out CONTROL, Inp(CONTROL) And &HFB
    
    Touches = (Inp(STATUS)) ' On capture l'état des touches...

    Select Case Touches ' ...Et on teste la touche appuyée
    
    Case 56
        Actif = "3"
        Flag = True
    Case 248
        Actif = "6"
        Flag = True
    Case 88
        Actif = "9"
        Flag = True
    Case 104
        Actif = "#"
        Flag = False ' On ne détecte pas ce signe car on s'en fout
    End Select
    
    If Flag = False Then ' On scanne la 2ième colonne seulement si on a encore rien détecté
    
    ' Deuxième colonne à 0V
    Out CONTROL, Inp(CONTROL) And &HFD
    Out CONTROL, Inp(CONTROL) And &HFB
    
    Touches = (Inp(STATUS))

    Select Case Touches
    
    Case 56
        Actif = "2"
        Flag = True
    Case 248
        Actif = "5"
        Flag = True
    Case 88
        Actif = "8"
        Flag = True
    Case 104
        Actif = "0"
        Flag = True
    End Select
    
    End If
    
    If Flag = False Then ' On scanne la 3ième colonne seulement si on a encore rien détecté
    
    ' Troisième colonne à 0V
     Out CONTROL, Inp(CONTROL) Or &H6

     Touches = (Inp(STATUS))

    Select Case Touches
    
    Case 56
        Actif = "1"
        Flag = True
    Case 248
        Actif = "4"
        Flag = True
    Case 88
        Actif = "7"
        Flag = True
    Case 104
        Actif = "*"
        Flag = False ' Même chose que pour #, ce n'est pas un chiffre donc on l'ignore
    End Select
    
    End If
    
    ' On récupère la touche pour construire le code
    If Flag = True Then
        Code_Saisi = (Val(Code_Saisi) * 10 + Actif)
        Text2.Text = Code_Saisi
        Call Ecrire_LCD(Actif, 64 + Nb_chiffres)
        Nb_chiffres = Nb_chiffres + 1
    End If
    
    ' 4 chiffres saisis, on teste la validité du code et on termine la scrutation
    If Nb_chiffres = 4 Then
        If Code_Saisi = Code_Reel Then
            Text3.Text = "Code bon, réinitialisez"
            Call Ecrire_LCD("Code bon        ", 0)
        Else
            Text3.Text = "Code faux, réinitialisez"
            Call Ecrire_LCD("Code faux       ", 0)
        End If
        Timer1.Enabled = False
    End If
End Sub

