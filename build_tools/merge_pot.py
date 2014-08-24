#! /usr/bin/python
# -*- coding=utf-8 -*-

import os

if __name__ == "__main__":
    path = os.path.join(os.getcwd(), "books", "User_Guide", "pot")
    dest_file = os.path.join(path, "User_Guide_Complete.pot")
    if os.path.exists(dest_file):
        os.unlink(dest_file)
    
    full_data = ""
    first_file = True
    for filename in os.listdir(path):
        if filename.endswith(".pot"):
            f = open(os.path.join(path, filename))
            data = f.read()
            f.close()
            if first_file:
                full_data += data
                first_file = False
            else:
                data = data.split("msgid \"")
                full_data += "msgid \"" + "msgid \"".join(data[2:])
    f = open(dest_file, "w")
    f.write(full_data)
    f.close()
