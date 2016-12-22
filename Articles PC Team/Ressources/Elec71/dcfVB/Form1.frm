VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Team DCF-77"
   ClientHeight    =   1635
   ClientLeft      =   4215
   ClientTop       =   2970
   ClientWidth     =   2880
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1635
   ScaleWidth      =   2880
   Begin VB.Timer Timer2 
      Left            =   3000
      Top             =   960
   End
   Begin VB.Timer Timer1 
      Left            =   3000
      Top             =   240
   End
   Begin VB.TextBox Text1 
      Height          =   735
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   2655
   End
   Begin VB.CommandButton Command2 
      Caption         =   "OFF"
      Height          =   615
      Left            =   1560
      TabIndex        =   1
      Top             =   960
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "ON"
      Height          =   615
      Left            =   240
      TabIndex        =   0
      Top             =   960
      Width           =   1095
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Gestion du module DCF-77 par le port série
' Note importante : ce programme n'est pas terminé, il manque notemment
' tout le décodage de la trame
' Contactez-moi pour tout renseignements complémentaires, et pour avoir
' une version un peu plus récente
' arabine@programmationworld.com

Dim Ok As Boolean
Dim Seconde As Integer
Dim Temps As Integer
Private Sub Command1_Click()
Dim i As Boolean
RTS 1
DTR 1
Ok = True
If Test_Recep = False Then
    MsgBox "Pas de signal"
    Ok = False
    RTS 0
    DTR 0
Else
     Ok = True
     Scan_COM
End If
End Sub

Private Sub Command2_Click()
 Ok = False
 RTS 0
 DTR 0
End Sub

Private Sub Form_Load()
Dim i As Integer
 i = OPENCOM("COM2,9600,M,8,1")
 If i = 0 Then MsgBox ("COM2 n'est pas disponible")
 Timer1.Interval = 50
 Timer1.Enabled = False
 Timer2.Interval = 1000
 Timer2.Enabled = False
 RTS 1
 DTR 1
End Sub

' Cette fonction se charge de vérifier si le récepteur envoie bien un signal qui change
Function Test_Recep() As Boolean
Dim i As Integer
Dim j As Integer
Seconde = 0
Timer2.Enabled = True
Do
    DoEvents
    If RI = 1 And Not (i) Then
        i = 1
    Else
        If Not (RI) And i = 1 Then
            j = 1
        End If
    End If
Loop While (Seconde <= 3) ' on teste la réception pendant 3 secondes
Timer2.Enabled = False
If i = 1 And j = 1 Then
    Test_Recep = True
Else
    Test_Recep = False
End If
End Function

' Cette fonction se charge de détecter le début de la trame
Private Sub Detect_Debut()
Dim Debut As Boolean
Debut = False
Text1.Text = "Détection début trame..."
Do
    Temps = 0
    ' on attend un 0 sur la ligne
    Do
        DoEvents
    Loop While (RI = 1)
    Timer1.Enabled = True
    ' On mesure ce temps à 0
    Do
        DoEvents
    Loop While (RI = 0) And (Temps <= 30)
    Timer1.Enabled = False
    ' on est sorti de la boucle à cause de l'abscence de signal pendant 1500ms
    If Temps > 30 Then
        Debut = True
    End If
Loop While Debut = False
'on sort de la boucle, le prochain caractère est significatif
End Sub

' Décodage de la trame proprement dite
Private Sub Scan_COM()
Dim Buffer As String
Dim i As Integer
Buffer = ""

' On détecte le début de la trame
Detect_Debut

'Le prochain bit est le premier, on démarre l'acquisition
Do
    DoEvents ' on laisse la main à d'autres applis tant qu'on a rien détecté
    If (RI = 0) Then ' le signal est à 0
        Temps = 0
        Do
            DoEvents
        Loop While (RI = 0) 'on détecte un front montant
        Timer1.Enabled = True
        Do
            DoEvents
        Loop While (Temps <= 3) 'on attend 150ms
        Timer1.Enabled = False
        Buffer = Buffer & Chr(RI + &H30)
    End If
Loop While (Ok <> False) And (Len(Buffer) < 58) 'on sort quand on a la trame complète
Text1.Text = "Trame finie"
End Sub

Private Sub Form_Unload(Cancel As Integer)
    CLOSECOM
End Sub

Private Sub Timer1_Timer()
    Temps = Temps + 1
End Sub

Private Sub Timer2_Timer()
    Seconde = Seconde + 1
End Sub
