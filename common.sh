ASH_STANDALONE=1

MODDIR=${0%/*}
SERVE_BIN="${MODDIR}/bin/frpc"
SERVE_CNF="${MODDIR}/bin/frpc.toml"
SERVE_LOG="${MODDIR}/service.log"
SERVE_PID="${MODDIR}/frpc.pid"

# start service
function start_service(){
	echo "$(date '+%Y-%m-%d %H:%M')"

	if [ -f "$SERVE_PID" ]; then
		PID=$(cat "$SERVE_PID")

		if kill -0 "$PID" 2>/dev/null; then
			echo "service is running. (PID: $PID)"
			return 0
		else
			rm -f "$SERVE_PID"
		fi
	fi
	echo "starting service..."
	$SERVE_BIN --config $SERVE_CNF &> $SERVE_LOG &
	echo $! > "$SERVE_PID"
}

# stop service
function stop_service(){
	echo "$(date '+%Y-%m-%d %H:%M')"

	if [ ! -f "$SERVE_PID" ]; then
		echo "pid file is not found."
		return 0
	fi

	PID=$(cat "$SERVE_PID")
	if kill -0 $PID 2>/dev/null; then
		echo "stopping service..."
		kill $PID
		rm -f "SERVE_PID"
	else
		echo "process is not found."
		rm -f "SERVE_PID"
	fi
}

# check service
function status_service(){
	if [ -f "$SERVE_PID" ]; then
		PID=$(cat "$SERVE_PID")
		if kill -0 "$PID" 2>/dev/null; then
			return 0
		else
			rm -f "$SERVE_PID"
			return 1
		fi
	fi
}
