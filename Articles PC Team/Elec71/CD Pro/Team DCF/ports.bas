Attribute VB_Name = "Module1"
Declare Function OPENCOM Lib "port.dll" (ByVal A$) As Integer
Declare Sub CLOSECOM Lib "port.dll" ()
Declare Sub SENDBYTE Lib "port.dll" (ByVal b%)
Declare Function READBYTE Lib "port.dll" () As Integer
Declare Sub DTR Lib "port.dll" (ByVal b%)
Declare Sub RTS Lib "port.dll" (ByVal b%)
Declare Function CTS Lib "port.dll" () As Integer
Declare Function DSR Lib "port.dll" () As Integer
Declare Function RI Lib "port.dll" () As Integer
Declare Function DCD Lib "port.dll" () As Integer
Declare Sub DELAY Lib "port.dll" (ByVal b%)
Declare Sub TIMEINIT Lib "port.dll" ()
Declare Sub TIMEINITUS Lib "port.dll" ()
Declare Function TIMEREAD Lib "port.dll" () As Long
Declare Function TIMEREADUS Lib "port.dll" () As Long
Declare Sub DELAYUS Lib "port.dll" (ByVal l As Long)
Declare Sub REALTIME Lib "port.dll" (ByVal i As Boolean)
Declare Sub OUTPORT Lib "port.dll" (ByVal A%, ByVal b%)
Declare Function INPORT Lib "port.dll" (ByVal p%) As Integer
Declare Function JOYX Lib "port.dll" () As Long
Declare Function JOYY Lib "port.dll" () As Long
Declare Function JOYZ Lib "port.dll" () As Long
Declare Function JOYW Lib "port.dll" () As Long
Declare Function JOYBUTTON Lib "port.dll" () As Integer
Declare Function SOUNDSETRATE Lib "port.dll" (ByVal Rate%) As Integer
Declare Function SOUNDGETRATE Lib "port.dll" () As Integer
Declare Function SOUNDBUSY Lib "port.dll" () As Boolean
Declare Function SOUNDIS Lib "port.dll" () As Boolean
Declare Sub SOUNDIN Lib "port.dll" (ByVal Puffer$, ByVal Size%)
Declare Sub SOUNDOUT Lib "port.dll" (ByVal Puffer$, ByVal Size%)
Declare Function SOUNDGETBYTES Lib "port.dll" () As Integer
Declare Function SOUNDSETBYTES Lib "port.dll" (ByVal b%) As Integer
Declare Sub SOUNDCAPIN Lib "port.dll" ()
Declare Sub SOUNCAPDOUT Lib "port.dll" ()

