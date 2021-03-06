{-# language ExistentialQuantification #-}
module Rasa.Internal.Events
  ( BeforeRender(..)
  , OnRender(..)
  , AfterRender(..)
  , BufAdded(..)
  , Keypress(..)
  , Mod(..)
  , BufTextChanged(..)
  ) where

import Data.Dynamic
import Rasa.Internal.Range
import Rasa.Internal.Buffer
import qualified Yi.Rope as Y

-- | This event is dispatched immediately before dispatching
-- the 'OnRender' event.
data BeforeRender = BeforeRender deriving (Show, Eq, Typeable)

-- | This event is dispatched when it's time for extensions to render to screen.
data OnRender = OnRender deriving (Show, Eq, Typeable)

-- | This event is dispatched immediately after dispatching 'OnRender'.
data AfterRender = AfterRender deriving (Show, Eq, Typeable)

-- | This event is dispatched after adding a new buffer. The contained BufRef refers to the new buffer.
data BufAdded = BufAdded BufRef deriving (Show, Eq, Typeable)

-- | This event is dispatched in response to keyboard key presses. It contains both
-- the char that was pressed and any modifiers ('Mod') that where held when the key was pressed.
data Keypress
  = Keypress Char [Mod]
  | KEsc      [Mod]
  | KBS       [Mod]
  | KEnter    [Mod]
  | KLeft     [Mod]
  | KRight    [Mod]
  | KUp       [Mod]
  | KDown     [Mod]
  | KPrtScr   [Mod]
  | KHome     [Mod]
  | KPageUp   [Mod]
  | KDel      [Mod]
  | KEnd      [Mod]
  | KPageDown [Mod]
  | KUnknown
  deriving (Show, Eq, Typeable)

-- | This represents each modifier key that could be pressed along with a key.
data Mod
  = Ctrl
  | Alt
  | Shift
  | Meta
  deriving (Show, Eq)

-- | This is triggered when text in a buffer is changed. The Event data includes the 'CrdRange' that changed and
-- the new text which is now contined in that range.
data BufTextChanged
  = BufTextChanged CrdRange Y.YiString
  deriving (Show, Eq, Typeable)
