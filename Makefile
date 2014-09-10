DEFAULT_LANG = en-US
USER_GUIDE_PATH = books/User_Guide
USER_GUIDE_DESKTOPS = cinnamon mate kde xfce
TRANSLATIONS_FIRTSNAME = Clément
TRANSLATIONS_SURNAME = Lefebvre
TRANSLATIONS_EMAIL = root@linuxmint.com
FORMATS = pdf,html#,html-single,html-desktop,txt,epub

all: build

build: clean pot po build_dir user_guide

build_dir:
	mkdir build

user_guide:
	for desktop in $(USER_GUIDE_DESKTOPS); \
	do \
		cd $(USER_GUIDE_PATH); \
		for lang in `ls`; \
		do \
			if [ -d "$$lang" -a "$$lang" != "pot" -a "$$lang" != "publish" -a "$$lang" != "tmp" ]; \
			then \
				if [ "$$lang" = "$(DEFAULT_LANG)" ]; \
				then \
					publican build --brand_dir=../../brands/Linux_Mint --config=publican_$$desktop.cfg --langs=$$lang --formats=$(FORMATS) --pdftool=fop --publish; \
					mv tmp/$$lang/xml publish/$$lang/Linux_Mint/`grep "ENTITY MINTVERSION" en-US/User_Guide.ent | awk -F'"' '{print $$2}'`/xml_$$desktop; \
				else \
					if [ "`publican lang_stats --lang=$$lang --config=publican_$$desktop.cfg | grep 'Total for' | awk '{print $$4}'`" = "0" ]; \
					then \
						publican build --brand_dir=../../brands/Linux_Mint --config=publican_$$desktop.cfg --langs=$$lang --formats=$(FORMATS) --pdftool=fop --publish; \
						mv tmp/$$lang/xml publish/$$lang/Linux_Mint/`grep "ENTITY MINTVERSION" en-US/User_Guide.ent | awk -F'"' '{print $$2}'`/xml_$$desktop; \
					fi; \
				fi; \
			fi; \
			echo ; \
		done; \
		cd ../..; \
	done
	mv $(USER_GUIDE_PATH)/publish/* build
	rmdir $(USER_GUIDE_PATH)/publish

clean:
	rm -rf tmp
	rm -rf build
	rm -rf $(USER_GUIDE_PATH)/tmp
	rm -rf $(USER_GUIDE_PATH)/publish

pot:
	for desktop in $(USER_GUIDE_DESKTOPS); \
	do \
		cd $(USER_GUIDE_PATH); \
		publican update_pot --brand_dir=../../brands/Linux_Mint --config=publican_$$desktop.cfg; \
		cd ../..; \
	done

po:
	for desktop in $(USER_GUIDE_DESKTOPS); \
	do \
		cd $(USER_GUIDE_PATH); \
		publican update_po --brand_dir=../../brands/Linux_Mint --config=publican_$$desktop.cfg --firstname=$(TRANSLATIONS_FIRTSNAME) --surname=$(TRANSLATIONS_SURNAME) --email=$(TRANSLATIONS_EMAIL); \
		cd ../..; \
	done
