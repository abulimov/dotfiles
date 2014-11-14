set SSH_ENV $HOME/.ssh/environment

function start_ssh_agent
    if [ -z "$SSH_AGENT_PID" ]
        if [ -f $SSH_ENV ]
            . $SSH_ENV > /dev/null
        end
        kill -0 $SSH_AGENT_PID > /dev/null
        if [ $status -ne 0 ]
            echo "Initializing new SSH agent ..."
            ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
            echo "succeeded"
            chmod 600 $SSH_ENV 
            . $SSH_ENV > /dev/null
        end
    end
end
