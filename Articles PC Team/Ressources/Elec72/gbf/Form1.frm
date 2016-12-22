VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   4620
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6615
   LinkTopic       =   "Form1"
   ScaleHeight     =   4620
   ScaleWidth      =   6615
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "STOP"
      Height          =   1215
      Left            =   3600
      TabIndex        =   1
      Top             =   1200
      Width           =   2535
   End
   Begin VB.CommandButton Command1 
      Caption         =   "GO"
      Height          =   1335
      Left            =   720
      TabIndex        =   0
      Top             =   1080
      Width           =   2055
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Ok As Boolean

Private Sub Command1_Click()
Ok = True
Do
    DoEvents
    OUTPORT &H278, INPORT(&H278) And &HEF ' bit 4 à 0
    DELAY 50
    OUTPORT &H278, INPORT(&H278) Or &H10 ' bit 4 à 1
    DELAY 50
Loop While Ok = True
End Sub

Private Sub Command2_Click()
    Ok = False
End Sub
