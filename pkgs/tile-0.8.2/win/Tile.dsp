# Microsoft Developer Studio Project File - Name="Tile" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) External Target" 0x0106

CFG=Tile - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Tile.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Tile.mak" CFG="Tile - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Tile - Win32 Release" (based on "Win32 (x86) External Target")
!MESSAGE "Tile - Win32 Debug" (based on "Win32 (x86) External Target")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName "Tile"
# PROP Scc_LocalPath ".."

!IF  "$(CFG)" == "Tile - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Tile___Win32_Release"
# PROP BASE Intermediate_Dir "Tile___Win32_Release"
# PROP BASE Cmd_Line "NMAKE /f Tile.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "Tile.exe"
# PROP BASE Bsc_Name "Tile.bsc"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Tile___Win32_Release"
# PROP Intermediate_Dir "Tile___Win32_Release"
# PROP Cmd_Line "nmake -f Makefile.vc INSTALLDIR=c:\opt\tcl TCLDIR=..\..\tcl84 TKDIR=..\..\tk84 OPTS=none all"
# PROP Rebuild_Opt "/a"
# PROP Target_File "Release/tile01.dll"
# PROP Bsc_Name ""
# PROP Target_Dir ""

!ELSEIF  "$(CFG)" == "Tile - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Tile___Win32_Debug"
# PROP BASE Intermediate_Dir "Tile___Win32_Debug"
# PROP BASE Cmd_Line "NMAKE /f Tile.mak"
# PROP BASE Rebuild_Opt "/a"
# PROP BASE Target_File "Tile.exe"
# PROP BASE Bsc_Name "Tile.bsc"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Tile___Win32_Debug"
# PROP Intermediate_Dir "Tile___Win32_Debug"
# PROP Cmd_Line "nmake -f Makefile.vc INSTALLDIR=c:\opt\tcl TCLDIR=..\..\tcl TKDIR=..\..\tk OPTS=symbols all"
# PROP Rebuild_Opt "/a"
# PROP Target_File "Debug/tile01g.dll"
# PROP Bsc_Name ""
# PROP Target_Dir ""

!ENDIF 

# Begin Target

# Name "Tile - Win32 Release"
# Name "Tile - Win32 Debug"

!IF  "$(CFG)" == "Tile - Win32 Release"

!ELSEIF  "$(CFG)" == "Tile - Win32 Debug"

!ENDIF 

# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\generic\altTheme.c
# End Source File
# Begin Source File

SOURCE=..\generic\button.c
# End Source File
# Begin Source File

SOURCE=..\generic\cache.c
# End Source File
# Begin Source File

SOURCE=..\generic\frame.c
# End Source File
# Begin Source File

SOURCE=..\generic\layout.c
# End Source File
# Begin Source File

SOURCE=.\monitor.c
# End Source File
# Begin Source File

SOURCE=..\generic\notebook.c
# End Source File
# Begin Source File

SOURCE=..\generic\pixmapTheme.c
# End Source File
# Begin Source File

SOURCE=..\generic\scale.c
# End Source File
# Begin Source File

SOURCE=..\generic\scrollbar.c
# End Source File
# Begin Source File

SOURCE=..\generic\stepTheme.c
# End Source File
# Begin Source File

SOURCE=..\generic\tile.c
# End Source File
# Begin Source File

SOURCE=..\generic\tkElements.c
# End Source File
# Begin Source File

SOURCE=..\generic\tkstate.c
# End Source File
# Begin Source File

SOURCE=..\generic\tkTheme.c
# End Source File
# Begin Source File

SOURCE=..\generic\trace.c
# End Source File
# Begin Source File

SOURCE=..\generic\track.c
# End Source File
# Begin Source File

SOURCE=..\generic\widget.c
# End Source File
# Begin Source File

SOURCE=.\winTheme.c
# End Source File
# Begin Source File

SOURCE=.\xpTheme.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\generic\compat.h
# End Source File
# Begin Source File

SOURCE=..\generic\gunk.h
# End Source File
# Begin Source File

SOURCE=..\generic\tkTheme.h
# End Source File
# Begin Source File

SOURCE=..\generic\widget.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# Begin Group "library"

# PROP Default_Filter ".tcl"
# Begin Source File

SOURCE=..\library\altTheme.tcl
# End Source File
# Begin Source File

SOURCE=..\library\button.tcl
# End Source File
# Begin Source File

SOURCE=..\library\defaults.tcl
# End Source File
# Begin Source File

SOURCE=..\library\keynav.tcl
# End Source File
# Begin Source File

SOURCE=..\library\menubutton.tcl
# End Source File
# Begin Source File

SOURCE=..\library\notebook.tcl
# End Source File
# Begin Source File

SOURCE=..\library\scale.tcl
# End Source File
# Begin Source File

SOURCE=..\library\scrollbar.tcl
# End Source File
# Begin Source File

SOURCE=..\library\stepTheme.tcl
# End Source File
# Begin Source File

SOURCE=..\library\tile.tcl
# End Source File
# Begin Source File

SOURCE=..\library\winTheme.tcl
# End Source File
# Begin Source File

SOURCE=..\library\xpTheme.tcl
# End Source File
# End Group
# Begin Group "demos"

# PROP Default_Filter "*.tcl"
# Begin Source File

SOURCE=..\demos\demo.tcl
# End Source File
# End Group
# Begin Source File

SOURCE=.\makefile.vc
# End Source File
# Begin Source File

SOURCE=..\generic\TODO
# End Source File
# End Target
# End Project
