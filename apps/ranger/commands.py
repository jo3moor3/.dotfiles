import subprocess
import json
import atexit
import socket
from pathlib import Path

import logging
logger = logging.getLogger(__name__)
import traceback

import os
import subprocess
from ranger.api.commands import Command
from ranger.container.file import File
from ranger.ext.get_executables import get_executables


