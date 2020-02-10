FROM alpine

# The ENTRYPOINT specifies a command that will always be executed when the container starts.
ENTRYPOINT ["/bin/ping"]