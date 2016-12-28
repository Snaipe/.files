import Prelude
import System.IO
import System.Exit
import XMonad
import Dzen

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Script
import XMonad.Hooks.EwmhDesktops

-- Layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.Maximize
import XMonad.Layout.ThreeColumns
import XMonad.Layout.IM
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Fullscreen
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

-- Data.Ratio for IM layout
import Data.Ratio ((%))
import Data.List (isInfixOf, null)

-- Moar keys
import Graphics.X11.ExtraTypes.XF86

-- Actions
import XMonad.Actions.CycleWS (nextWS, prevWS)
import XMonad.Actions.CycleWindows

import XMonad.Util.Run
import XMonad.Util.NamedWindows
import XMonad.Util.EZConfig (additionalKeys)
import Control.Monad (liftM2, replicateM_)
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Char (isSpace)

------------------------------------------------------------------------
-- Terminal
--

myTerminal = "/usr/bin/termite"


------------------------------------------------------------------------
-- Workspaces
--

myWorkspaces = ["main","text","dev","web","mail","chat","media","gimp","games"]


------------------------------------------------------------------------
-- Window rules
--

myManageHook = composeAll . concat $
  [
    -- Applications that go to text.
      [ className =? b --> viewShift "text" | b <- myClassTextShifts ]

    -- Applications that go to ide.
    , [ className =? c --> viewShift "dev" | c <- myClassDevShifts ]

    -- Applications that go to web.
    , [ className =? d --> viewShift "web" | d <- myClassWebShifts ]

    -- Applications that go to mail.
    , [ className =? e --> viewShift "mail" | e <- myClassMailShifts ]

    -- Applications that go to chat.
    , [ className =? f --> viewShift "chat" | f <- myClassChatShifts ]

    -- Applications that go to media.
    , [ className =? g --> viewShift "media" | g <- myClassMediaShifts ]

    -- Applications that go to games.
    , [ className =? h --> viewShift "games" | h <- myClassGamesShifts ]

    -- Gimp goes to its own workspace.
    , [ className =? i --> viewShift "gimp" | i <- myGimpShift ]

    -- Applications that need floating regardless of workspace.
    , [ className =? j --> doCenterFloat | j <- myClassFloats ]
    , [ resource  =? k --> doCenterFloat | k <- myResourceFloats ]

    -- Applications that need to be ignored.
    , [ className =? l --> doIgnore | l <- myClassIgnores ]
    , [ resource  =? m --> doIgnore | m <- myResourceIgnores ]

    -- Applications that need to be added to slave panel when created.
    --, [ className =? "termite" --> doF (W.swapDown) ]

    , [ isFullscreen --> (doF W.focusDown <+> doFullFloat) ]
  ]
  where
      viewShift          = doF . liftM2 (.) W.greedyView W.shift
      myClassTextShifts  = ["gvim","vim"]
      myClassDevShifts   = ["jetbrains-idea"]
      myClassWebShifts   = ["Firefox","Chromium"]
      myClassMailShifts  = ["Thunderbird"]
      myClassChatShifts  = ["Pidgin", "Skype", "weechat"]
      myClassMediaShifts = ["Audacity", "vlc", "ncmpcpp", "alsamixer"]
      myGimpShift        = ["Gimp"]
      myClassGamesShifts = ["Steam"]
      myClassFloats      = ["feh", "mpv", "Transmission-gtk", "Nm-connection-editor", "File Operation Progress"]
      myResourceFloats   = ["Downloads", "Dialog", "Places", "Browser"]
      myClassIgnores     = ["stalonetray"]
      myResourceIgnores  = ["desktop_window"]


------------------------------------------------------------------------
-- Layout Hook
--

fullLayout = noBorders (fullscreenFull Full)

myLayoutHook = maximize $
               mkToggle (NOBORDERS ?? FULL ?? EOT) $
               onWorkspace "chat" chatLayout $
               onWorkspace "gimp" gimpLayout $
               defaultLayouts
    where
      layouts        =
        spacing 10 (tiled
          ||| Mirror tiled
          ||| Full
          ||| threeCol)
        ||| fullLayout
      defaultLayouts = avoidStruts(layouts)
      chatLayout     = noBorders(avoidStruts(IM (1%5) (Or (Title "Buddy List") (And (Resource "main") (ClassName "pidgin")))
                       ||| fullLayout))
      gimpLayout     = noBorders(avoidStruts((withIM (0.12) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full)))

      tiled    = Tall nmaster delta ratio
      threeCol = ThreeCol nmaster delta ratio
      nmaster  = 1
      delta    = 3/100
      ratio    = 1/2


------------------------------------------------------------------------
-- Colors and borders
--

-- Custom theme colors
magenta   = "#ed6666"
green     = "#83be49"
yellow    = "#ffff00"
orange    = "#ff9c00"
violet    = "#b98a93"
blue      = "#468284"
white     = "#cccccc"
lightGrey = "#cfcfcf"
darkGrey  = "#444444"
black     = "#000000"
lime      = "#7aba7a"

mainDark = "#101010"

-- Border colors
myNormalBorderColor  = darkGrey
myFocusedBorderColor = lightGrey

-- Width of the window border in pixels.
myBorderWidth = 1

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod1Mask
appMask = mod4Mask


myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- Custom key bindings
  --

  [
  ----------------------------------------------------------------------
  -- Application keybinds
  --

  -- Start a terminal.  Terminal to start is specified by myTerminal variable.
    ((appMask,    xK_Return), spawn $ XMonad.terminal conf)

  -- Launch dmenu.
  , ((appMask, xK_BackSpace), spawn "PATH=/home/snaipe/cli:$PATH dmenu_run -fn 'Meslo LG M DZ for Powerline' -y 270 -x 320 -w 1280 -p '>' -q -r -z -dim 0.7 -l 22 -nb '#101010' -nf '#cfcfcf' -sb '#ed6666' -sf '#000000'")

  -- Launch weechat
  , ((appMask,         xK_i), spawn "termite --class=weechat -e weechat-curses")

  -- Launch ranger
  , ((appMask,     xK_space), spawn "termite --class=ranger -e 'zsh -c ranger'")

  -- Launch firefox
  , ((appMask,         xK_f), spawn "firefox")

  -- Launch ncmpcpp
  -- (Multimedia key)
  , ((0,         0x1008ff32), spawn "termite --class=ncmpcpp -e ncmpcpp")
  -- (Custom shortcut)
  , ((appMask,         xK_m), spawn "termite --class=ncmpcpp -e ncmpcpp")

  ----------------------------------------------------------------------
  -- Xmonad controls
  --
  , ((modMask, xK_f), sendMessage $ Toggle FULL)

  , ((modMask .|. controlMask, xK_Right), nextWS)
  , ((modMask .|. controlMask, xK_Left), prevWS)
  , ((modMask .|. controlMask, xK_Up), replicateM_ 4 $ nextWS)
  , ((modMask .|. controlMask, xK_Down), replicateM_ 4 $ prevWS)

  , ((modMask .|. shiftMask, xK_Up), rotFocusedUp)
  , ((modMask .|. shiftMask, xK_Down), rotFocusedDown)

  -- Lock the screen using xscreensaver.
  , ((modMask .|. controlMask, xK_l),
     spawn "xscreensaver-command -lock")

  , ((0, xF86XK_Sleep), spawn "systemctl suspend")
  , ((0, xF86XK_ScreenSaver), spawn "i3lock")

  -- Maximize window
  , ((modMask, xK_Up), withFocused (sendMessage . maximizeRestore))

  -- Change Brightness
  , ((0,         xF86XK_MonBrightnessUp), spawn "~/bin/backlightctl 15")
  , ((shiftMask, xF86XK_MonBrightnessUp), spawn "~/bin/backlightctl 5")
  , ((0,         xF86XK_MonBrightnessDown), spawn "~/bin/backlightctl -15")
  , ((shiftMask, xF86XK_MonBrightnessDown), spawn "~/bin/backlightctl -5")

  -- Mute volume.
  , ((0,         xF86XK_AudioMute), spawn "amixer -q set Master toggle")

  -- Decrease volume.
  , ((0,         xF86XK_AudioLowerVolume), spawn "amixer -q set Master 5%-")
  , ((shiftMask, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 1%-")

  -- Increase volume.
  , ((shiftMask, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 1%+")
  , ((0,         xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 5%+")

  -- Audio previous.
  -- (Multimedia Key))
  , ((0, 0x1008FF16),
     spawn "mpc prev")
  -- (Custom shortcut)
  , ((modMask, xK_bracketleft),
     spawn "mpc prev")

  -- Play/pause.
  -- (Multimedia key)
  , ((0, 0x1008FF14),
     spawn "mpc toggle")
  -- (Custom shortcut)
  , ((modMask, xK_backslash),
     spawn "mpc toggle")

  -- Audio next.
  -- (Multimedia key)
  , ((0, 0x1008FF17),
     spawn "mpc next")
  -- (Custom shortcut)
  , ((modMask, xK_bracketright),
     spawn "mpc next")

  -- Eject CD tray.
  , ((0, 0x1008FF2C),
     spawn "eject -T")

  -- Rebind mod + q: custom restart xmonad script
  , ((modMask, xK_q),
     spawn "killall dzen2 && xmonad --recompile && xmonad --restart")

  --------------------------------------------------------------------
  -- "Standard" xmonad key bindings
  --

  -- Close focused window.
  , ((modMask .|. shiftMask, xK_c),
     kill)

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space),
     sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space),
     setLayout $ XMonad.layoutHook conf)

  -- Resize viewed windows to the correct size.
  , ((modMask, xK_n),
     refresh)

  -- Move focus to the next window.
  , ((modMask, xK_Tab),
     windows W.focusDown)

  -- Move focus to the next window.
  , ((modMask, xK_j),
     windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k),
     windows W.focusUp  )

  -- Move focus to the master window.
  , ((modMask, xK_m),
     windows W.focusMaster  )

  -- Swap the focused window and the master window.
  , ((modMask, xK_Return),
     windows W.swapMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j),
     windows W.swapDown  )

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k),
     windows W.swapUp    )

  -- Shrink the master area.
  , ((modMask, xK_h),
     sendMessage Shrink)

  -- Expand the master area.
  , ((modMask, xK_l),
     sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask, xK_t),
     withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((modMask, xK_comma),
     sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((modMask, xK_n),
     sendMessage (IncMasterN (-1)))

  -- Quit xmonad.
  , ((modMask .|. shiftMask, xK_q),
     io (exitWith ExitSuccess))
  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)
      | (i, k) <- zip (XMonad.workspaces conf) [
                   xK_ampersand, xK_eacute, xK_quotedbl, xK_apostrophe,
                   xK_parenleft, xK_minus, xK_egrave, xK_underscore, xK_ccedilla,
                   xK_agrave, xK_parenright, xK_equal
                  ]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  ++

  -- mod-{z,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{z,e,r}, Move client to screen 1, 2, or 3
  [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
      | (key, sc) <- zip [xK_z, xK_e, xK_r] [0..]
      , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings
--

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
  [
    -- mod-button1, Set the window to floating mode and move by dragging
    ((modMask, button1),
     (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2),
       (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3),
       (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
  ]


------------------------------------------------------------------------
-- Status bars and logging
--

-- Log hook that prints out everything to a dzen handler.
myLogHook h = dynamicLogWithPP $ myPrettyPrinter h

-- Pretty printer for dzen workspace bar.
myPrettyPrinter h = dzenPP
  {
    ppOutput          = hPutStrLn h
  , ppCurrent         = dzenColor black magenta . pad
  , ppHidden          = dzenColor white mainDark . pad . clickable myWorkspaces . trimSpace
  , ppHiddenNoWindows = dzenColor darkGrey mainDark . pad . clickable myWorkspaces . trimSpace
  , ppUrgent          = dzenColor black orange . pad . clickable myWorkspaces . trimSpace . dzenStrip
  , ppWsSep           = " · "
  , ppSep             = " | "
  , ppTitle           = (" " ++) . dzenColor magenta mainDark . shorten 120 . dzenEscape
  , ppLayout          = dzenColor white mainDark . pad .
                        (\x -> case x of
                          "SimplestFloat"                   -> "Float"
                          "Maximize Spacing 10 Tall"        -> "^i(.xmonad/icons/layout_tall.xbm)"
                          "Maximize Spacing 10 Mirror Tall" -> "^i(.xmonad/icons/layout_mirror_tall.xbm)"
                          "Maximize IM"                     -> "^i(.xmonad/icons/layout_im.xbm)"
                          "Maximize IM ReflectX IM Full"    -> "^i(.xmonad/icons/layout_gimp.xbm)"
                          "Maximize Spacing 10 ThreeCol"    -> "^i(.xmonad/icons/layout_threecol.xbm)"
                          "Maximize Spacing 10 Full"        -> "^i(.xmonad/icons/layout_full.xbm)"
                          "Maximize Full"                   -> "^i(.xmonad/icons/layout_full.xbm)"
                          _                                 -> x
                        )
  }

-- Wraps a workspace name with a dzen clickable action that focusses that workspace.
clickable workspaces workspace = clickableExp workspaces 1 workspace

clickableExp [] _ ws = ws
clickableExp (ws:other) n l | l == ws = "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()"
                            | otherwise = clickableExp other (n+1) l

-- Trims leading and trailing white space.
trimSpace = f . f
    where f = reverse . dropWhile isSpace

myDzenFont = "Meslo LG M DZ:pixelsize=12"

myDzen = DzenConf {
    font       = Just myDzenFont
  , bg_color   = Just mainDark
  , exec       = ["button2=;"]
  , addargs    = []
}

-- Workspace dzen bar
myWorkDzen = myDzen {
    x_position = Just 0
  , y_position = Just 0
  , width      = Just 1810
  , height     = Just 32
  , alignment  = Just LeftAlign
  , fg_color   = Just lightGrey
}

-- Music dzen bar
myMusicDzen = myDzen {
    x_position = Just 0
  , y_position = Just 1080
  , width      = Just 700
  , height     = Just 24
  , alignment  = Just LeftAlign
  , fg_color   = Just violet
}

-- System information dzen bar
mySysInfoDzen = myDzen {
    x_position = Just 700
  , y_position = Just 1080
  , width      = Just 1220
  , height     = Just 24
  , alignment  = Just RightAlign
  , fg_color   = Just green
}

------------------------------------------------------------------------
-- Startup hook
-- By default, do nothing.
--
myStartupHook = execScriptHook "xmodmap"

------------------------------------------------------------------------
-- Urgency hook
--
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset

        safeSpawn "notify-send" [show name, "workspace " ++ idx]

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--

main = do
  workspaceBar <- spawnDzen myWorkDzen
  spawnToDzen "conky -c ~/.xmonad/conky/sysinfo" mySysInfoDzen
  spawnToDzen "conky -c ~/.xmonad/conky/music" myMusicDzen
  xmonad $ withUrgencyHook LibNotifyUrgencyHook $ ewmh defaults {
        logHook     = myLogHook workspaceBar
      , manageHook  = manageDocks <+> myManageHook
      , startupHook = setWMName "LG3D"
      , handleEventHook = XMonad.Hooks.EwmhDesktops.fullscreenEventHook
  }

------------------------------------------------------------------------
-- Combine it all together
--
defaults = defaultConfig {
    -- simple stuff
    terminal           = myTerminal,
    focusFollowsMouse  = myFocusFollowsMouse,
    borderWidth        = myBorderWidth,
    modMask            = myModMask,
    workspaces         = myWorkspaces,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor,

    -- key bindings
    keys               = myKeys,
    mouseBindings      = myMouseBindings,

    -- hooks, layouts
    layoutHook         = myLayoutHook,
    manageHook         = myManageHook,
    startupHook        = myStartupHook
}
