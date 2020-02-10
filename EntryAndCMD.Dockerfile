FROM alpine

# The ENTRYPOINT specifies a command that will always be executed when the container starts.
ENTRYPOINT ["/bin/ping"]

# The CMD specifies arguments that will be fed to the ENTRYPOINT.
CMD ["localhost"]