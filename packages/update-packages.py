#! /usr/bin/python
# -*- coding=utf-8 -*-

import os

languages = {
			'en-US':'C', 
            'pt-BR':'pt_BR'
            }

os.system("rm -rf mint-user-guide/mint-user-guide-cinnamon/*")
os.system("rm -rf mint-user-guide/mint-user-guide-mate/*")

for language in languages.keys():
	yelp_language = languages[language]

	os.system("mkdir -p mint-user-guide/mint-user-guide-cinnamon/usr/share/help/%s/linuxmint/" % yelp_language)
	os.system("mkdir -p mint-user-guide/mint-user-guide-mate/usr/share/help/%s/linuxmint/" % yelp_language)
	
	for book in ['Cinnamon', 'Mate']:
		for content in ['Common_Content', 'images', 'Book_Info.xml', 'user-guide-%s-*' % book.lower(), 'user-guide-common-*']:
			os.system("cp -R ../books/User_Guide/tmp/%s/xml/%s mint-user-guide/mint-user-guide-%s/usr/share/help/%s/linuxmint/" % (language, content, book.lower(), yelp_language))
		# copy the index
		os.system("cp -R ../books/User_Guide/tmp/%s/xml/%s_User_Guide.xml mint-user-guide/mint-user-guide-%s/usr/share/help/%s/linuxmint/index.docbook" % (language, book, book.lower(), yelp_language))

# clean up images
os.system("rm -rf mint-user-guide/mint-user-guide-cinnamon/usr/share/help/*/linuxmint/images/desktops/mate")
os.system("rm -rf mint-user-guide/mint-user-guide-mate/usr/share/help/*/linuxmint/images/desktops/cinnamon")
