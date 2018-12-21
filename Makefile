VERSION = 1.2

PN = odroid-c2-rtc
PREFIX ?= /usr
INITDIR = $(PREFIX)/lib/systemd/system
LIVEDIR = $(PREFIX)/lib/systemd/system/sysinit.target.wants
HOOKDIR = $(PREFIX)/share/libalpm/hooks
BLKLDIR = $(PREFIX)/lib/modprobe.d

INSTALL = install -p
INSTALL_DATA = $(INSTALL) -m644
INSTALL_DIR = $(INSTALL) -d

target:
	/bin/true

install:
	$(INSTALL_DIR) "$(DESTDIR)$(HOOKDIR)" "$(DESTDIR)$(LIVEDIR)" "$(DESTDIR)$(BLKLDIR)"
	$(INSTALL_DATA) hooks/99-linux-$(PN).hook "$(DESTDIR)$(HOOKDIR)/99-linux-$(PN).hook"
	$(INSTALL_DATA) init/$(PN).service "$(DESTDIR)$(INITDIR)/$(PN).service"
	ln -s ../$(PN).service "$(DESTDIR)$(LIVEDIR)/$(PN).service"
	echo "blacklist sx865x" > "$(DESTDIR)$(BLKLDIR)/$(PN).conf"

uninstall:
	rm "$(DESTDIR)$(HOOKDIR)/99-linux-$(PN).hook" \
		"$(DESTDIR)$(INITDIR)/$(PN).service" \
		"$(DESTDIR)$(LIVEDIR)/$(PN).service" \
		"$(DESTDIR)$(BLKLDIR)/$(PN).conf"

.PHONY: install uninstall
