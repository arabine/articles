VERSION 5.00
Begin VB.Form MainForm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TeamScope"
   ClientHeight    =   4785
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5130
   Icon            =   "MainForm.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4785
   ScaleWidth      =   5130
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   3495
      Left            =   480
      ScaleHeight     =   3465
      ScaleWidth      =   4545
      TabIndex        =   3
      Top             =   120
      Width           =   4575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "STOP"
      Height          =   495
      Left            =   1800
      TabIndex        =   2
      Top             =   3720
      Width           =   1215
   End
   Begin VB.Timer Timer1 
      Left            =   2160
      Top             =   4320
   End
   Begin VB.CommandButton Command1 
      Caption         =   "GO"
      Height          =   495
      Left            =   480
      TabIndex        =   1
      Top             =   3720
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   3120
      TabIndex        =   0
      Top             =   4080
      Width           =   1455
   End
   Begin VB.Label Label4 
      Caption         =   "0V"
      Height          =   375
      Left            =   120
      TabIndex        =   7
      Top             =   3480
      Width           =   255
   End
   Begin VB.Label Label3 
      Caption         =   "5V"
      Height          =   375
      Left            =   120
      TabIndex        =   6
      Top             =   1800
      Width           =   255
   End
   Begin VB.Label Label2 
      Caption         =   "V"
      Height          =   375
      Left            =   4680
      TabIndex        =   5
      Top             =   4200
      Width           =   375
   End
   Begin VB.Label Label1 
      Caption         =   "Valeur Moyenne :"
      Height          =   255
      Left            =   3120
      TabIndex        =   4
      Top             =   3720
      Width           =   1335
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de gestion d'un convertisseur analogique numérique
' Anthony Rabine pour PC Team 72 Octobre 2001
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble
' Configuration de l'électronique (port parallèle : ADC0831)
' D0 (broche 2) : CLK
' D1 (broche 3): /CS
' /ACK (broche 10): D0
Dim Tab_Prec(199) As Double
Dim Tab_cour(199) As Double
Dim BasePort As Integer
Dim Status As Integer

Private Sub Command1_Click()
    Timer1.Enabled = True
End Sub

Private Sub Command2_Click()
    Timer1.Enabled = False
End Sub

Private Sub Form_Load()

Timer1.Enabled = False
Timer1.Interval = 100

BasePort = &H278 ' Deuxième port parallèle
Status = BasePort + 1

'picGraphe.Scale (xmin, ymax)-(xmax, ymin)
Picture1.Scale (0, 10)-(200, 0)

' Dessine l'axe X
Picture1.Line (0, 0)-(200, 0)

' Dessine l'axe Y
Picture1.Line (0, 0)-(0, 10)

End Sub

Function BinToDec(stNbBin As String) As Double
' Transforme un binaire en décimal
Dim lgLen As Long
Dim dlResultat As Double, lgDeux As Double
Dim stTmp As String
lgLen = Len(stNbBin)
stTmp = StrReverse(stNbBin)
lgDeux = 0.01953125 '1
For lgFor = 1 To lgLen
    dlResultat = dlResultat + CLng(Mid$(stTmp, lgFor, 1)) * lgDeux
    lgDeux = lgDeux * 2
Next lgFor
BinToDec = dlResultat
End Function

' Cette fonction permet de lire la donnée numérisée
' Voir le datasheet pour les chronogrammes
' Les masquages sont là pour laisser les autres broches libres

Function Read_ADC() As String
    Dim Buffer As String
    Buffer = ""
    Dim i As Integer
    
    ' Cette série de niveaux sert  à demander le résultat de la conversion
    OUTPORT BasePort, INPORT(BasePort) Or &H2 ' /CS à 1
    OUTPORT BasePort, INPORT(BasePort) And &HFE 'CLK à 0
    OUTPORT BasePort, INPORT(BasePort) Or &H1 'CLK à 1
    OUTPORT BasePort, INPORT(BasePort) And &HFD ' /CS à 0
    OUTPORT BasePort, INPORT(BasePort) And &HFE 'CLK à 0
    OUTPORT BasePort, INPORT(BasePort) Or &H1 'CLK à 1
    
    ' La lecture proprement dite
    For i = 0 To 7
        OUTPORT BasePort, INPORT(BasePort) And &HFE 'CLK à 0
        OUTPORT BasePort, INPORT(BasePort) Or &H1 'CLK à 1 'on lit la valeur
        Buffer = Buffer & (INPORT(Status) And &H40) / 64
    Next i
    
    'On termine proprement la séquence de lecture
    OUTPORT BasePort, INPORT(BasePort) And &HFE 'CLK à 0
    OUTPORT BasePort, INPORT(BasePort) Or &H1 'CLK à 1
    OUTPORT BasePort, INPORT(BasePort) And &HFE 'CLK à 0
    OUTPORT BasePort, INPORT(BasePort) Or &H2 ' /CS à 1
    Read_ADC = Buffer
End Function

Private Sub Timer1_Timer()
    Dim i As Integer
    Dim Total As Double ' somme des valeurs pour calculer la moyenne
    Total = 0
    
    ' il y a encore du boulot à faire, par exemple la synchro
    ' Ce qui serait bien , c'est de copier la face avant
    ' d'un oscilloscope :o)
        
    ' On enregistre les 200 points
    For i = 0 To 199
        Tab_cour(i) = BinToDec(Read_ADC) * 2
        Picture1.PSet (i, Tab_Prec(i)), QBColor(15) ' un point en blanc pour effacer la courbe précédente
        Picture1.PSet (i, Tab_cour(i)), QBColor(0) ' un point en noir
        Total = Total + Tab_cour(i)
        Tab_Prec(i) = Tab_cour(i) ' on sauvegarde les points actuels pour le prochain coup
    Next i
    ' on affiche la moyenne (ne signifie pas grand chose, ce n'est PAS
    ' le vrai calcul pour avoir la valeur moyenne efficace vraie
    Text1.Text = Str(Total / 200)
End Sub
