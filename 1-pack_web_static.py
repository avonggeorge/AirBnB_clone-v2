#!/usr/bin/python3
 """
Generates a .tgz archive from the contents of the web_static folder
"""
from fabric.api import local
from datetime import datetime


def do_pack():
    """
    Generates a .tgz archive from the contents of the web_static folder
    """
    # Create the versions folder if it doesn't exist
    local("mkdir -p versions")

    # Create the name for the archive based on current time
    time_format = "%Y%m%d%H%M%S"
    current_time = datetime.utcnow().strftime(time_format)
    archive_name = "web_static_{}.tgz".format(current_time)

    # Compress the contents of web_static into the archive
    result = local("tar -cvzf versions/{} web_static".format(archive_name))

    # Check if the archive was generated successfully
    if result.succeeded:
        return "versions/{}".format(archive_name)
    else:
        return None
