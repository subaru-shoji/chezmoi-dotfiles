#!/usr/bin/env bb
(require '[babashka.process :as p :refer [process]]
  )

(-> (process "xdg-open https://calendar.google.com/calendar/u/0/r"))
