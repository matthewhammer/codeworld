{-# LANGUAGE OverloadedStrings #-}

{-
  Copyright 2020 The CodeWorld Authors. All rights reserved.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-}
import CodeWorld.GameServer
import Control.Applicative
import Snap.Core
import Snap.Http.Server

main :: IO ()
main = do
  state <- initGameServer
  config <-
    commandLineConfig
      $ setPort 9160
      $ setErrorLog (ConfigFileLog "log/game-error.log")
      $ setAccessLog (ConfigFileLog "log/game-access.log")
      $ mempty
  httpServe config $
    ifTop (gameStats state) <|> route [("gameserver", gameServer state)]
