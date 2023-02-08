# !/bin/bash
find . -name "target" -type d -prune | xargs du -chs
find . -name "target" -type d -prune -exec rm -rf '{}' +
