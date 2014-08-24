DEFAULT_LANG = en-US
USER_GUIDE_PATH = books/User_Guide
USER_GUIDE_CONFIGS = publican_cinnamon.cfg publican_mate.cfg
TRANSLATIONS_FIRTSNAME = Clément
TRANSLATIONS_SURNAME = Lefebvre
TRANSLATIONS_EMAIL = root@linuxmint.com

all: build

build: clean pot po build_dir user_guide

build_dir:
	mkdir build

user_guide:
	for book_config in $(USER_GUIDE_CONFIGS); \
	do \
		cd $(USER_GUIDE_PATH); \
		for lang in `ls`; \
		do \
			if [ -d "$$lang" -a "$$lang" != "pot" -a "$$lang" != "publish" -a "$$lang" != "tmp" ]; \
			then \
				if [ "$$lang" = "$(DEFAULT_LANG)" ]; \
				then \
					publican build --config=$$book_config --langs=$$lang --formats=pdf,html-single --pdftool=fop --publish; \
					rm -rf tmp; \
				else \
					if [ "`publican lang_stats --lang=$$lang --config=$$book_config | grep 'Total for' | awk '{print $$4}'`" = "0" ]; \
					then \
						publican build --config=$$book_config --langs=$$lang --formats=pdf,html-single --pdftool=fop --publish; \
						rm -rf tmp; \
					fi; \
				fi; \
			fi; \
		done; \
		cd ../..; \
	done
	mv $(USER_GUIDE_PATH)/publish/* build
	rmdir $(USER_GUIDE_PATH)/publish

clean:
	rm -rf tmp
	rm -rf build
	rm -rf $(USER_GUIDE_PATH)/publish

pot:
	for book_config in $(USER_GUIDE_CONFIGS); \
	do \
		cd $(USER_GUIDE_PATH); \
		publican update_pot --config=$$book_config; \
		cd ../..; \
	done
	python build_tools/merge_pot.py

po:
	for book_config in $(USER_GUIDE_CONFIGS); \
	do \
		cd $(USER_GUIDE_PATH); \
		publican update_po --config=$$book_config --firstname=$(TRANSLATIONS_FIRTSNAME) --surname=$(TRANSLATIONS_SURNAME) --email=$(TRANSLATIONS_EMAIL); \
		cd ../..; \
	done
