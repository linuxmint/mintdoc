#! /usr/bin/python
# -*- coding=utf-8 -*-

import os

if __name__ == "__main__":
    path = os.path.join(os.getcwd(), "books", "User_Guide")
    langs = [l for l in os.listdir(path) if os.path.isdir(os.path.join(path, l)) and not l in ["build", "tmp", "pot", "en-US"]]
    
    pot_files = [os.path.join(path, "pot", f) for f in os.listdir(os.path.join(path, "pot")) if f.endswith(".pot") and not f.endswith("_Complete.pot")]
    ids_to_files = {}
    for filename in pot_files:
        f = open(filename)
        data = f.read().split("msgid \"")
        f.close()
        for item in data:
            msgid = "\"".join(item.split("msgstr \"")[0].split("\"")[:-1])
            ids_to_files.setdefault(msgid, []).append(os.path.split(filename)[1])
    
    for lang in langs:
        files_data = {}
        complete_po_file = os.path.join(path, lang, "User_Guide_Complete.po")
        if os.path.exists(complete_po_file):
            f = open(complete_po_file)
            data = f.read().split("msgid \"")
            f.close()
            for item in data:
                msgid = "\"".join(item.split("msgstr \"")[0].split("\"")[:-1])
                if msgid != "":
                    for dest_filename in ids_to_files[msgid]:
                        files_data.setdefault(dest_filename[:-1], {})[msgid] = item
        for dest_filename in files_data:
            f = open(os.path.join(path, lang, dest_filename), "w")
            f.write("msgid \"" + "msgid \"".join(files_data[dest_filename].values()))
            f.close()
