VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "TeamPuce"
   ClientHeight    =   4710
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6495
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4710
   ScaleWidth      =   6495
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   3855
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   720
      Width           =   6255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Lecture"
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Programme de lecture de carte à puce
' Anthony Rabine pour PC Team 70 Juillet/Août 2001
' arabine@programmationworld.com
' Vous pouvez utiliser ce logiciel comme bon vous semble
'
'************************************************************
' N'hésitez pas à m'envoyer vos oeuvres pour les mettre sur le CD
'
' Configuration de l'électronique pour ce programme:
' E/S : broche 10 (/ACK status bit 6) (entrée non inversée)
' Read/Write : broche 3 (data bit 1)
' Horloge : boche 4 (data bit 2)
' Reset/Up : broche 5 (data bit 3)
Dim BASEPORT As Integer
Dim STATUS As Integer

Private Sub Command1_Click()
    Text1.Text = ""
    Text1.Text = Lecture
End Sub

Function Lecture() As String
    Dim Buffer As String
    Dim Buffer2 As String
    Dim i As Integer
    Dim Valeur As Integer
    Buffer = ""
    Buffer2 = ""
    i = 0
    Call Reset_Puce
    
    ' On lit les 512 bits
    Do
        Buffer = Buffer & Int(Inp(STATUS) And &H40) / 64 ' On lit et on stocke la valeur
        Delay (20)
        Out BASEPORT, Inp(BASEPORT) Or &H4 ' Horloge = 1 le compteur d'adresse est incrémenté
        Delay (20)
        Out BASEPORT, Inp(BASEPORT) And &HFB ' Horloge = 0, la donnée est présente sur la ligne
        Delay (20)
        i = i + 1
    Loop While i < 512
    
    ' Petit algo pour ranger proprement les chiffres en paquets d'octets
    For i = 1 To 512
        If i Mod 8 Then
            Buffer2 = Buffer2 & Mid(Buffer, i, 1)
        Else
            Buffer2 = Buffer2 & Mid(Buffer, i, 1) & " "
        End If
    Next i
    Lecture = Buffer2
End Function

Private Sub Form_Load()
    ' Adresse du port parallèle
    BASEPORT = &H378    ' LPT1
    STATUS = BASEPORT + 1

    Call Reset_Puce
End Sub

Private Sub Reset_Puce()
    ' Initialisation de la carte
    Out BASEPORT, &H0 ' Tout à 0
    Delay (20)
    ' On initialise le compteur d'adresse
    Out BASEPORT, &H4 ' Horloge = 1
    Delay (20)
    Out BASEPORT, &H0 ' Horloge = 0
    Delay (20)
    Out BASEPORT, &H8 ' reset = 1
End Sub

Private Sub Delay(ByVal Temps As Integer)
    'Fonction perte de temps faite maison
    Dim i As Long
    Dim j As Long
    For i = 0 To Temps
        For j = 0 To Temps
        Next j
    Next i
End Sub
