all: build

build: clean
	mkdir build
	publican build --src_dir=books/User_Guide --config=publican_cinnamon.cfg --langs=en-US,pt-BR --formats=pdf,html-single --pdftool=fop --publish
	rm -rf tmp
	publican build --src_dir=books/User_Guide --config=publican_mate.cfg --langs=en-US,pt-BR --formats=pdf,html-single --pdftool=fop --publish
	rm -rf tmp
	mv books/User_Guide/publish/* build
	rmdir books/User_Guide/publish

clean:
	rm -rf tmp
	rm -rf build
	rm -rf books/User_Guide/publish

pot:
	cd books/User_Guide && publican update_pot --config=publican_cinnamon.cfg && cd ../..
	cd books/User_Guide && publican update_pot --config=publican_mate.cfg && cd ../..
