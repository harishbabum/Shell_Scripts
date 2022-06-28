#!/bin/bash
#/etc/init.d/zookeeper
KAFKA_PATH=/opt/kafka_2.13-3.0.0/bin
SERVICE_NAME=zookeeper

PATH=$PATH:$KAFKA_PATH

case "$1" in
  start)
        # Start daemon.
        pid=`ps ax | grep -i 'org.apache.zookeeper' | grep -v grep |
 awk '{print $1}'`
        if [ -n "$pid" ]
          then
            echo "Zookeeper is already running";
        else
          echo "Starting $SERVICE_NAME";
          $KAFKA_PATH/zookeeper-server-start.sh -daemon /opt/kafka_2.13-3.0.0/config/zookeeper.properties
        fi
        ;;
  stop)
        echo "Shutting down $SERVICE_NAME";
        $KAFKA_PATH/zookeeper-server-stop.sh
        ;;
  restart)
        $0 stop
        sleep 2
        $0 start
        ;;
  status)
        pid=`ps ax | grep -i 'org.apache.zookeeper' | grep -v grep |
 awk '{print $1}'`
        if [ -n "$pid" ]
          then
          echo "Zookeeper is Running as PID: $pid"
        else
          echo "Zookeeper is not Running"
        fi
        ;;
  *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0
