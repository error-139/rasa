module Rasa.Ext.Slate.Internal.State (getVty) where

import Rasa.Ext

import Control.Lens
import Control.Monad.Trans
import qualified Graphics.Vty as V

-- | Store 'V.Vty' state globally
newtype Slate = Slate V.Vty
instance Show Slate where
  show _ = "Slate"

-- | V.Vty must be initialized, this takes IO to perform.
initUi :: App V.Vty
initUi = do
  cfg <- liftIO V.standardIOConfig
  v <- liftIO $ V.mkVty cfg
  ext .= Just (Slate v)
  return v

-- | Gets vty by checking if it has been initialized yet, if not it runs the initialization.
getVty :: App V.Vty
getVty = do
  v <- use ext
  case v of
    Just (Slate v') -> return v'
    Nothing -> initUi
