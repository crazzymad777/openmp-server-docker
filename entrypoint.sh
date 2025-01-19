#!/bin/bash

# Prepare server.cfg for running
if [ -f ${SAMP_SERVER_DIR}/server.cfg.lock ]; then
	sed -i -e 's/rcon_password/#rcon_password/g' $SAMP_SERVER_DIR/server.cfg.lock
	echo rcon_password `xxd -l16 -ps /dev/urandom` >> $SAMP_SERVER_DIR/server.cfg.lock
	mv ${SAMP_SERVER_DIR}/server.cfg{.lock,}
fi

${SAMP_SERVER_DIR}/samp03svr
