Attribute VB_Name = "inpout"
' D�claration des fonctions int�gr�es � la dll
' Usage :
' Out PortAddress, ValueToWrite
' ValueRead = Inp(PortAddress)

Public Declare Function Inp Lib "inpout32.dll" _
Alias "Inp32" (ByVal PortAddress As Integer) As Integer
Public Declare Sub Out Lib "inpout32.dll" _
Alias "Out32" (ByVal PortAddress As Integer, ByVal Value As Integer)
