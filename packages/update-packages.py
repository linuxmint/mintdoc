#! /usr/bin/python
# -*- coding=utf-8 -*-

import os, commands

languages = {
			'en-US':'C', 
            'pt-BR':'pt_BR'
            }

books = ['Cinnamon', 'Mate', 'KDE', 'Xfce']

os.system("rm -rf mint-user-guide/mint-user-guide-*/*")

base_dir = os.getcwd()

for language in languages.keys():
	if os.path.exists("../books/User_Guide/tmp/%s" % language):
		yelp_language = languages[language]
		
		for book in books:						
			source_dir = "%s/../books/User_Guide/tmp/%s/xml" % (base_dir, language)
			dest_dir = "%s/mint-user-guide/mint-user-guide-%s/usr/share/help/%s/linuxmint/" % (base_dir, book.lower(), yelp_language)
			os.system("mkdir -p %s" % dest_dir)
			os.chdir(dest_dir)

			# copy common chapters
			for content in ['Common_Content', 'images', 'Book_Info.xml', 'user-guide-common-*']:
				os.system("cp -R %s/%s ./" % (source_dir, content))

			# copy DE specific chapters if any
			try:
				os.system("cp -R %s/user-guide-%s-* ./ 2> /dev/null" % (source_dir, book.lower()))
			except:
				pass
			
			# copy the index
			os.system("cp %s/%s_User_Guide.xml ./index.docbook" % (source_dir, book))

			# Find the title
			title = commands.getoutput("grep \<title\> Book_Info.xml").replace('<title>', '').replace('</title>', '').strip()
			# set the subtitle as the title
			os.system("sed  -i 's/\<subtitle\>.*\<subtitle\>/subtitle>%s<\/subtitle/' Book_Info.xml" % title)
			# set the title as the product name and version number
			os.system("sed  -i 's/\<title\>.*\<title\>/title>\&PRODUCT; \&MINTVERSION;<\/title/' Book_Info.xml")

			# Replace the EDITION to the correct value
			os.system("grep -r -l '<!ENTITY EDITION \".*\">' * | xargs sed -i 's/<!ENTITY EDITION \".*\">/<!ENTITY EDITION \"%s\">/g'" % book)			

			# clean up images
			for name in books:
				if book != name:
					os.system("rm -rf images/desktops/%s" % name)

os.chdir(base_dir)