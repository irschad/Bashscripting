# Bashscripting
General shell scripting practice

1. installjava.sh :
    Notes:
    > /dev/null suppresses stdout, ensuring that only the version information (which is on stderr) is captured.
    2>&1 redirects stderr (where the version info is) to stdout so that the command substitution ($(...)) can capture it into the variable java_version.
