
        select_system_python23()
        {
            echo "Setting environment for System Python 2.3"
            PATH="/System/Library/Frameworks/Python.framework/Versions/2.3/bin/:${OLD_PATH}"
            export PATH

            # export PS1='(System Python 2.3) [\h:\w]$ '

        }
                
        select_system_python25()
        {
            echo "Setting environment for System Python 2.5"
            PATH="/System/Library/Frameworks/Python.framework/Versions/2.5/bin/:${OLD_PATH}"
            export PATH

            # export PS1='(System Python 2.5) [\h:\w]$ '

        }
                
        select_system_python26()
        {
            echo "Setting environment for System Python 2.6"
            PATH="/System/Library/Frameworks/Python.framework/Versions/2.6/bin/:${OLD_PATH}"
            export PATH

            # export PS1='(System Python 2.6) [\h:\w]$ '

        }
                
        select_system_python27()
        {
            echo "Setting environment for System Python 2.7"
            PATH="/System/Library/Frameworks/Python.framework/Versions/2.7/bin/:${OLD_PATH}"
            export PATH

            # export PS1='(System Python 2.7) [\h:\w]$ '

        }
                
        select_macpython27()
        {
            echo "Setting environment for MacPython 2.7"
            PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin/:${OLD_PATH}"
            export PATH

            # export PS1='(MacPython 2.7) [\h:\w]$ '

        }
                
        select_macpython33()
        {
            echo "Setting environment for MacPython 3.3"
            PATH="/Library/Frameworks/Python.framework/Versions/3.3/bin/:${OLD_PATH}"
            export PATH

            # export PS1='(MacPython 3.3) [\h:\w]$ '

        }
                