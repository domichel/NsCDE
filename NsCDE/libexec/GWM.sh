#!/bin/ksh

#
# This file is a part of the NsCDE - Not so Common Desktop Environment
# Author: Hegel3DReloaded
# Licence: GPLv3
#

OLD_LC_ALL="$LC_ALL"
IFS=" "

function usage
{
   echo "Usage: ${0##*/} -w <vp width> -h <vp height> -f <reduction factor> -d <no of desks> | [ -H ]"
   exit $1
}

while getopts w:h:f:d:H Option
do
   case $Option in
      w)
         width=$OPTARG
      ;;
      h)
         height=$OPTARG
      ;;
      f)
         wfactor=$OPTARG
      ;;
      d)
         ndesks=$OPTARG
      ;;
      H)
         usage 0
      ;;
   esac
done

# Parse WSM.conf
if [ -r "${FVWM_USERDIR}/WSM.conf" ]; then
   WSMCONF_R="${FVWM_USERDIR}/WSM.conf"
   WSMCONF_W="${FVWM_USERDIR}/WSM.conf"
else
   if [ -r "${NSCDE_ROOT}/config/WSM.conf" ]; then
      WSMCONF_R="${NSCDE_ROOT}/config/WSM.conf"
      WSMCONF_W="${FVWM_USERDIR}/WSM.conf"
   else
      WSMCONF_W="${FVWM_USERDIR}/WSM.conf"
   fi
fi

WsmReadRows=$(egrep "^GWM:${ndesks}:ROWS:[[:digit:]]" $WSMCONF_R)
WsmRows="${WsmReadRows##*:}"

if [ "x$WsmRows" != "x" ]; then
   Rows=$WsmRows
   case $ndesks in
   2)
      if (($Rows == 1)); then
         Cols=2
      else
         Cols=1
      fi
   ;;
   4)
      if (($Rows == 1)); then
         Cols=4
      elif (($Rows == 2)); then
         Cols=2
      elif (($Rows == 4)); then
         Cols=1
      fi
   ;;
   6)
      if (($Rows == 1)); then
         Cols=6
      elif (($Rows == 2)); then
         Cols=3
      elif (($Rows == 3)); then
         Cols=2
      elif (($Rows == 6)); then
         Cols=1
      fi
   ;;
   8)
      if (($Rows == 1)); then
         Cols=8
      elif (($Rows == 2)); then
         Cols=4
      elif (($Rows == 4)); then
         Cols=2
      elif (($Rows == 8)); then
         Cols=1
      fi
   ;;
   esac
else
   case $ndesks in
   2)
      Rows=2
      Cols=1
   ;;
   4)
      Rows=2
      Cols=2
   ;;
   6)
      Rows=2
      Cols=3
   ;;
   8)
      Rows=4
      Cols=2
   ;;
   esac
fi

WsmReadWscale=$(egrep "^GWM:${ndesks}:WSCALE:[10-20]" $WSMCONF_R)
WsmWscale="${WsmReadWscale##*:}"

if [ "x$WsmWscale" != "x" ]; then
   Width=$(($WsmWscale * 16.5))
else
   Width=$(($wfactor * 16.5))
   WsmWscale=$wfactor
fi

Width=${Width%%.*}

# Initial calculations
WindowWidth=$(($Width * $Cols))
PagerWidth=$(($Width * $Cols))
PagerHeight=$((((($Width * $height) / $width) + 20) * $Rows))
WindowHeight=$(($PagerHeight + 32))
WidgetHelpVisible=""

# Help menu item on the right calculations
# Just for the sake of having it Motif style.
case ${ndesks}${Rows}${Cols}${WsmWscale} in
22110|22111|22112|22113|44110|44111|44112|44113|66110|66111|66112|66113|88110|88111|88112|88113)
   HelpMenuPadding=""
   WidgetHelpVisible="HideWidget 4"
;;
22114|44114|66114|88114)
   HelpMenuPadding=""
;;
22115|44115|66115|88115)
   HelpMenuPadding="0"
;;
22116|44116|66116|88116)
   HelpMenuPadding=$(for n in {0..1}; do echo -ne 0; done)
;;
22117|44117|66117|88117)
   HelpMenuPadding=$(for n in {0..3}; do echo -ne 0; done)
;;
22118|44118|66118|88118)
   HelpMenuPadding=$(for n in {0..5}; do echo -ne 0; done)
;;
22119|44119|66119|88119)
   HelpMenuPadding=$(for n in {0..6}; do echo -ne 0; done)
;;
22120|44120|66120|88120)
   HelpMenuPadding=$(for n in {0..8}; do echo -ne 0; done)
;;
21210|42210|63210|84210)
   HelpMenuPadding=$(for n in {0..8}; do echo -ne 0; done)
;;
21211|42211|63211|84211)
   HelpMenuPadding=$(for n in {0..11}; do echo -ne 0; done)
;;
21212|42212|63212|84212)
   HelpMenuPadding=$(for n in {0..14}; do echo -ne 0; done)
;;
21213|42213|63213|84213)
   HelpMenuPadding=$(for n in {0..18}; do echo -ne 0; done)
;;
21214|42214|63214|84214)
   HelpMenuPadding=$(for n in {0..21}; do echo -ne 0; done)
;;
21215|42215|63215|84215)
   HelpMenuPadding=$(for n in {0..24}; do echo -ne 0; done)
;;
21216|42216|63216|84216)
   HelpMenuPadding=$(for n in {0..28}; do echo -ne 0; done)
;;
21217|42217|63217|84217)
   HelpMenuPadding=$(for n in {0..31}; do echo -ne 0; done)
;;
21218|42218|63218|84218)
   HelpMenuPadding=$(for n in {0..34}; do echo -ne 0; done)
;;
21219|42219|63219|84219)
   HelpMenuPadding=$(for n in {0..37}; do echo -ne 0; done)
;;
21220|42220|63220|84220)
   HelpMenuPadding=$(for n in {0..41}; do echo -ne 0; done)
;;
41410|82410)
   HelpMenuPadding=$(for n in {0..41}; do echo -ne 0; done)
;;
41411|82411)
   HelpMenuPadding=$(for n in {0..47}; do echo -ne 0; done)
;;
41412|82412)
   HelpMenuPadding=$(for n in {0..54}; do echo -ne 0; done)
;;
41413|82413)
   HelpMenuPadding=$(for n in {0..60}; do echo -ne 0; done)
;;
41414|82414)
   HelpMenuPadding=$(for n in {0..67}; do echo -ne 0; done)
;;
41415|82415)
   HelpMenuPadding=$(for n in {0..74}; do echo -ne 0; done)
;;
41416|82416)
   HelpMenuPadding=$(for n in {0..80}; do echo -ne 0; done)
;;
41417|82417)
   HelpMenuPadding=$(for n in {0..87}; do echo -ne 0; done)
;;
41418|82418)
   HelpMenuPadding=$(for n in {0..93}; do echo -ne 0; done)
;;
41419|82419)
   HelpMenuPadding=$(for n in {0..100}; do echo -ne 0; done)
;;
41420|82420)
   HelpMenuPadding=$(for n in {0..107}; do echo -ne 0; done)
;;
62310)
   HelpMenuPadding=$(for n in {0..24}; do echo -ne 0; done)
;;
62311)
   HelpMenuPadding=$(for n in {0..29}; do echo -ne 0; done)
;;
62312)
   HelpMenuPadding=$(for n in {0..34}; do echo -ne 0; done)
;;
62313)
   HelpMenuPadding=$(for n in {0..39}; do echo -ne 0; done)
;;
62314)
   HelpMenuPadding=$(for n in {0..44}; do echo -ne 0; done)
;;
62315)
   HelpMenuPadding=$(for n in {0..49}; do echo -ne 0; done)
;;
62316)
   HelpMenuPadding=$(for n in {0..54}; do echo -ne 0; done)
;;
62317)
   HelpMenuPadding=$(for n in {0..59}; do echo -ne 0; done)
;;
62318)
   HelpMenuPadding=$(for n in {0..64}; do echo -ne 0; done)
;;
62319)
   HelpMenuPadding=$(for n in {0..69}; do echo -ne 0; done)
;;
62320)
   HelpMenuPadding=$(for n in {0..74}; do echo -ne 0; done)
;;
61610)
   HelpMenuPadding=$(for n in {0..74}; do echo -ne 0; done)
;;
61611)
   HelpMenuPadding=$(for n in {0..84}; do echo -ne 0; done)
;;
61612)
   HelpMenuPadding=$(for n in {0..94}; do echo -ne 0; done)
;;
61613)
   HelpMenuPadding=$(for n in {0..103}; do echo -ne 0; done)
;;
61614)
   HelpMenuPadding=$(for n in {0..113}; do echo -ne 0; done)
;;
61615)
   HelpMenuPadding=$(for n in {0..123}; do echo -ne 0; done)
;;
61616)
   HelpMenuPadding=$(for n in {0..133}; do echo -ne 0; done)
;;
61617)
   HelpMenuPadding=$(for n in {0..143}; do echo -ne 0; done)
;;
61618)
   HelpMenuPadding=$(for n in {0..153}; do echo -ne 0; done)
;;
61619)
   HelpMenuPadding=$(for n in {0..163}; do echo -ne 0; done)
;;
61620)
   HelpMenuPadding=$(for n in {0..173}; do echo -ne 0; done)
;;
81810)
   HelpMenuPadding=$(for n in {0..107}; do echo -ne 0; done)
;;
81811)
   HelpMenuPadding=$(for n in {0..120}; do echo -ne 0; done)
;;
81812)
   HelpMenuPadding=$(for n in {0..133}; do echo -ne 0; done)
;;
81813)
   HelpMenuPadding=$(for n in {0..146}; do echo -ne 0; done)
;;
81814)
   HelpMenuPadding=$(for n in {0..159}; do echo -ne 0; done)
;;
81815)
   HelpMenuPadding=$(for n in {0..172}; do echo -ne 0; done)
;;
81816)
   HelpMenuPadding=$(for n in {0..186}; do echo -ne 0; done)
;;
81817)
   HelpMenuPadding=$(for n in {0..199}; do echo -ne 0; done)
;;
81818)
   HelpMenuPadding=$(for n in {0..212}; do echo -ne 0; done)
;;
81819)
   HelpMenuPadding=$(for n in {0..225}; do echo -ne 0; done)
;;
81820)
   HelpMenuPadding=$(for n in {0..239}; do echo -ne 0; done)
;;
esac

# Generate script
cat <<EOF
UseGettext {$NSCDE_ROOT/share/locale;NsCDE-GWM}
WindowLocaleTitle {GWM}
WindowSize ${WindowWidth} ${WindowHeight}
Colorset 22

Init
Begin
   Do {Schedule 200 Exec exec rm -f $[FVWM_USERDIR]/tmp/GWM}
   Do {f_PrepareGWMPager $Rows $Cols $Width}

   $WidgetHelpVisible

   Set \$MenuFont = (GetOutput {\$NSCDE_ROOT/bin/getfont -v -t normal -s medium -Z 14} 1 -1)
   ChangeFont 1 \$MenuFont
   ChangeFont 2 \$MenuFont
   ChangeFont 4 \$MenuFont

   Key Q C 1 1 {Quit}
   Key Help A 4 1 {DisplayHelp}
   Key F1 A 4 1 {DisplayHelp}
End

# PeriodicTasks
# Begin
# End

Widget 1
   Property
   Type Menu
   Position 0 10
   Flags NoReliefString Left
   Value 0
   Title { Workspace|Manage Workspaces ...|Rename ...|Cascade All Windows|Tile All Windows Vertically|Tile All Windows Horizontally|Options ...|Exit}
   Font "xft:::pixelsize=18:charwidth=9.8"
   Main
      Case message of
      SingleClic :
      Begin
         # Manage Workspaces
         If (GetValue 1) == 1 Then
         Begin
            Do {f_ToggleFvwmModule FvwmScript WsPgMgr \$[infostore.desknum] \$[infostore.pagematrixX] \$[infostore.pagematrixY]}
         End
         # Rename
         If (GetValue 1) == 2 Then
         Begin
            HideWidget 6
            Do {f_GWMRenameWorkspaceHelper}
            SendSignal 3 1
         End
         # Cascade All Windows
         If (GetValue 1) == 3 Then
         Begin
            HideWidget 6
            Do {Module FvwmRearrange -cascade -incx 8 -incy 6 6 2 \$[wa.width]p \$[wa.height]p}
            SendSignal 3 1
         End
         # Tile All Windows Vertically
         If (GetValue 1) == 4 Then
         Begin
            HideWidget 6
            Do {f_TileWindows}
            SendSignal 3 1
         End
         # Tile All Windows Horizontally
         If (GetValue 1) == 5 Then
         Begin
            HideWidget 6
            Do {f_TileWindows -h}
            SendSignal 3 1
         End
         # Options
         If (GetValue 1) == 6 Then
         Begin
            HideWidget 6
            Do {Module FvwmScript GWMOptions}
            SendSignal 3 1
         End
         # Exit
         If (GetValue 1) == 7 Then
         Begin
            HideWidget 6
            Do {Schedule 10 SendToModule $[FVWM_USERDIR]/tmp/GWM SendString 1 1 Quit}
         End
      End
      1 :
      Begin
         If (LastString) == {Quit} Then
         Begin
            Do {KillModule FvwmPager GWMPager}
            Do {Schedule 250 SendToModule $[FVWM_USERDIR]/tmp/GWM SendString 1 2 QExit}
         End
      End
      2 :
      Begin
         If (LastString) == {QExit} Then
         Begin
            Quit
         End
      End
End

Widget 2
   Property
   Type Menu
   Position 0 20
   Flags NoReliefString Left
   Value 0
   Title { Window|(De)Iconify|(De)Shade|Close Window|Terminate Application|Occupy Workspace ...}
   Font "xft:::pixelsize=18:charwidth=9.8"
   Main
      Case message of
      SingleClic :
      Begin
         If (GetValue 2) == 1 Then
         Begin
            HideWidget 6
            Do {Prev Iconify toggle}
            SendSignal 3 1
         End
         If (GetValue 2) == 2 Then
         Begin
            HideWidget 6
            Do {Prev WindowShade toggle}
            SendSignal 3 1
         End
         If (GetValue 2) == 3 Then
         Begin
            HideWidget 6
            Do {Prev Close}
            SendSignal 3 1
         End
         If (GetValue 2) == 4 Then
         Begin
            HideWidget 6
            Do {Prev Destroy}
            SendSignal 3 1
         End
         If (GetValue 2) == 5 Then
         Begin
            HideWidget 6
            Do {Prev f_SendToOccupy wsp nogo}
            SendSignal 3 1
         End
      End
End

Widget 3
   Property
   Type Menu
   Position 0 389
   Flags NoReliefString Left Hidden
   Value 0
   Title {$HelpMenuPadding}
   Font "xft:::pixelsize=12:spacing=mono:charwidth=10"
   Main
      Case message of
      SingleClic :
      Begin
      End
      1 :
      Begin
         Do {Schedule 168 SendToModule $[FVWM_USERDIR]/tmp/GWM SendString 3 2 ShowPager}
      End
      2 :
      Begin
         If (LastString) == {ShowPager} Then
         Begin
            ShowWidget 6
         End
      End
End

Widget 4
   Property
   Type Menu
   Position 0 389
   Flags NoReliefString Left
   Value 0
   Title { Help|GWM Help}
   Font "xft:::pixelsize=18:charwidth=9.8"
   Main
      Case message of
      SingleClic :
      Begin
         SendSignal 4 1
      End
      1 :
      Begin
         Do {f_DisplayURL "\$[gt.GWM]" \$[NSCDE_ROOT]/share/doc/html/NsCDE-GWM.html}
      End
End

Widget 6
   Property
   Size ${PagerWidth} ${PagerHeight}
   Position 2 30
   Type SwallowExec
   Title {GWMPager}
   SwallowExec {Module FvwmPager GWMPager 0 \$[infostore.fvwmdesknum]}
   Flags NoReliefString, Center
   Value 1
   Colorset 22
End

EOF

