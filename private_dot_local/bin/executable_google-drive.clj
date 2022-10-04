#!/usr/bin/env bb
(require '[babashka.process :as p :refer [process]]
  )

(-> (process "xdg-open https://drive.google.com/drive/u/0/my-drive"))
