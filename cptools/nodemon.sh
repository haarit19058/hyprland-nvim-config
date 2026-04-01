#!/bin/bash 

if [ "$#" -lt 2 ]; then
    echo "Usage: ./watcher.sh <file_to_watch> <command_to_run>"
    echo "Example: ./watcher.sh main.cpp g++"
    echo "Example: ./watcher.sh script.py python3"
    exit 1
fi

FILE=$1
CMD_TYPE=$2
PID=""

# --- CLEANUP HANDLER ---
# This runs when you press Ctrl+C to stop the watcher script
cleanup() {
    echo -e "\nExiting watcher. Cleaning up..."
    # Kill the running process if PID is set
    [ -n "$PID" ] && kill $PID 2>/dev/null
    # Remove the compiled binary if it exists
    [ -f "sol" ] && rm -f sol
    exit 0
}
# Catch SIGINT (Ctrl+C) and SIGTERM and route them to the cleanup function
trap cleanup SIGINT SIGTERM

# --- PROCESS STARTER ---
start_process() {
    # Check if the command is a C/C++ compiler
    if [[ "$CMD_TYPE" == "gcc" || "$CMD_TYPE" == "g++" ]]; then
        echo "Compiling $FILE..."
        
        # Compile the file first (Foreground process)
        $CMD_TYPE "$FILE" -o sol
        
        # Check if compilation was successful ($? gets the exit code of the last command)
        if [ $? -eq 0 ]; then
            echo "Compilation successful. Running ./sol..."
            ./sol &
            PID=$!
        else
            echo "Compilation failed. Waiting for you to fix the errors..."
            PID="" # No process to kill later
        fi
    else
        # For Python, Node, etc.
        echo "Running $FILE with $CMD_TYPE..."
        $CMD_TYPE "$FILE" &
        PID=$!
    fi
}

# 1. Get the initial modification time
LAST_MOD=$(stat -c %Y "$FILE")

# 2. Initial Run
start_process

echo "Watching $FILE for changes... (Press Ctrl+C to exit and clean up)"

# 3. The Infinite Loop
while true; do
    sleep 1
    
    CURRENT_MOD=$(stat -c %Y "$FILE")
    
    if [ "$CURRENT_MOD" != "$LAST_MOD" ]; then
        echo -e "\nDetected changes in $FILE. Restarting..."
        
        # Kill the old process if it is currently running
        if [ -n "$PID" ]; then
            kill $PID 2>/dev/null
        fi

        # Remove the old compiled binary before recompiling
        if [[ "$CMD_TYPE" == "gcc" || "$CMD_TYPE" == "g++" ]]; then
            [ -f "sol" ] && rm -f sol
        fi

        # Start the new process
        start_process
        
        # Update the timestamp
        LAST_MOD=$CURRENT_MOD
    fi
done
