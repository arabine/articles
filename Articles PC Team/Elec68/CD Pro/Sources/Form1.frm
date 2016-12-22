VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Essai DS1620"
   ClientHeight    =   1305
   ClientLeft      =   600
   ClientTop       =   1860
   ClientWidth     =   2325
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1305
   ScaleWidth      =   2325
   Begin VB.Timer Timer1 
      Left            =   360
      Top             =   240
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Lancer la capture"
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Top             =   720
      Width           =   2055
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   375
      Left            =   1320
      MaxLength       =   3
      TabIndex        =   0
      Top             =   120
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Temp�rature :"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de test du DS1620
' Anthony Rabine pour PC Team 68 Mai 2001
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble
'
'************************************************************
' N'h�sitez pas � m'envoyer vos oeuvres pour les mettre sur le CD
'
' Configuration de l'�lectronique :
' Clock : broche 3 (data bit 1)
' /Reset : broche 2 (data bit 0)
' DQ : boche 16 (control bit 2)

Dim LPT_DATA As Integer
Dim LPT_CONTROL As Integer
Dim Flag As Boolean

Private Sub Command1_Click()
    If Flag = False Then
        Command1.Caption = "Arr�ter la capture"
        Timer1.Enabled = True
        Flag = True
    Else
        Text1.Text = ""
        Command1.Caption = "Lancer la capture"
        Timer1.Enabled = False
        Flag = False
    End If
End Sub

Private Sub Form_Load()
    LPT_DATA = &H378 ' Adresse du port parall�le
    LPT_CONTROL = LPT_DATA + 2
    Out LPT_DATA, (Inp(LPT_DATA) And &HFE) ' /Reset = 0
    Out LPT_DATA, (Inp(LPT_DATA) Or &H2) ' Clock = 1
    Timer1.Interval = 1000
    Timer1.Enabled = False
    Flag = False
End Sub

' Voici la fonction qui lit une donn�e dans le DS1620
' Notez qui si le protocole est &hAA, la donn�e lue est la temp�rature courante

Function Read_DS1620(ByVal Protocol As Integer) As Integer
    Dim n As Integer
    Dim j As Integer
    Dim Donnee As Integer
    Dim Sortie As Integer
    Sortie = 0
    Donnee = 0
    Out LPT_DATA, (Inp(LPT_DATA) Or &H1) ' /Reset = 1
    
    ' Phase 1 : On �crit le protocole
    For j = 1 To 8
        Out LPT_DATA, (Inp(LPT_DATA) And &HFD) ' Clock = 0
        Delay (200)
        
        ' on place le bit sur l'entr�e
        n = Protocol And 1 ' cela permet de masquer le LSB
        If n = 1 Then
            Out LPT_CONTROL, (Inp(LPT_CONTROL) Or &H4) ' DQ = 1
        Else
            Out LPT_CONTROL, (Inp(LPT_CONTROL) And &HFB) ' DQ = 0
        End If
        
        ' PAF ! on provoque un front montant pour valider la valeur
        Out LPT_DATA, (Inp(LPT_DATA) Or &H2) ' Clock = 1
        Delay (200)
        Protocol = Int(Protocol / 2) ' on d�cale vers la droite pour tester le bit suivant
    Next j
    
    ' Phase 2 : on lit la donn�e
    ' Note : si c'est une temp�rature, la donn�e est sur 9 bits, sinon c'est sur 8
    ' bits : il faudrait tester le protocole et changer cela en fonction (c pas dur � faire,
    ' un if ... then ... else .... suffit
    For j = 1 To 9
        ' on g�n�re un front descendant (la valeur reste sur le niveau 1 apr�s)
        Out LPT_DATA, (Inp(LPT_DATA) Or &H2) ' Clock = 1
        Delay (200)
        Out LPT_DATA, (Inp(LPT_DATA) And &HFD) ' Clock = 0
        Delay (200)
        n = (Inp(LPT_CONTROL) And &H4) / 4
        If n = 1 Then Donnee = Donnee + 1
        If j <> 9 Then Donnee = Donnee * 2 ' on d�cale vers la gauche, sauf pour la derni�re valeur
        ' Notez que ce test peut �tre effac� si vous ne divisez pas la sortie par 2 � la fin de
        ' cette fonction. C'est une petite astuce mais je ne l'ai pas faite pour �viter toute confusion
    Next j
    Out LPT_DATA, (Inp(LPT_DATA) And &HFE) ' /Reset = 0
    
    ' On inverse le nombre pour avoir le LSB et le MSB bien plac�s
    For j = 0 To 8
        Sortie = Sortie + (Donnee And 2 ^ j) / (2 ^ j)
        If j <> 8 Then Sortie = Sortie * 2
    Next j
    
    Read_DS1620 = Sortie / 2 ' on divise par deux car la r�solution est 0,5�C par LSB
End Function

Private Sub Delay(ByVal Temps As Integer)
    ' Petite fonction de perte de temps bien bourrine. Je ne sais pas si elle est
    ' n�cessaire mais c'est pour �tre bien au niveau des chronogrammes
    Dim i As Long
    Dim j As Long
    For i = 0 To Temps
        For j = 0 To Temps
        Next j
    Next i
End Sub

Private Sub Timer1_Timer()
    ' On lit une nouvelle valeur de la temp�rature toutes les secondes
    Text1.Text = Read_DS1620(&HAA)
End Sub
