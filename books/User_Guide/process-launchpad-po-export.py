#!/usr/bin/python

import os

for item in os.listdir("launchpad-po-export"):    
    dir_path = os.path.join("launchpad-po-export", item)
    if item == "user-guide-book-info":
        dest = "Book_Info"
    else:
        dest = item
    for po in os.listdir(dir_path):
        if po.endswith(".po"):
            locale = po.split('.po')[0].split('-')[-1].replace('_', '-')
            source = os.path.join(dir_path, po)            
            os.system("mkdir -p %s" % locale)
            os.system("cp %s %s/%s.po" % (source, locale, dest))
            