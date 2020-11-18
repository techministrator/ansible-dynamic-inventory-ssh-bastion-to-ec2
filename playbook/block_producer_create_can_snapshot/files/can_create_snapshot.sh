#!/bin/bash +x
SNAPSHOT_CREATION_RESP=$(curl -X POST http://127.0.0.1:8888/v1/producer/create_snapshot) 
SNAPSHOT_HEAD_BLOCK_ID=$(echo $SNAPSHOT_CREATION_RESP | jq -r .head_block_id)
SNAPSHOT_FILE_PATH=$(echo $SNAPSHOT_CREATION_RESP | jq -r .snapshot_name)
SNAPSHOT_FOLDER_PATH=$(echo $SNAPSHOT_FILE_PATH | grep -oh '.*snapshots')
TODAY=$(date +%FT%T)

mv $SNAPSHOT_FILE_PATH "${SNAPSHOT_FOLDER_PATH}/snapshot-${TODAY}.bin"