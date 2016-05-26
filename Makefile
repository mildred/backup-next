DESTDIR=
PREFIX=/usr/local
BINDIR=$(PREFIX)/bin
SHAREDIR=$(PREFIX)/share
ETCDIR=$(PREFIX)/etc

help:
	@echo "make DESTDIR=... PREFIX=$(PREFIX) install"

install:
	mkdir -p $(DESTDIR)$(BINDIR) $(DESTDIR)$(SHAREDIR)/backup/ $(DESTDIR)$(ETCDIR)/backup.d/
	install -m644 backup.d/README.md $(DESTDIR)$(ETCDIR)/backup.d/README.md
	install -m755 backup $(DESTDIR)$(BINDIR)/backup
	rm -rf $(DESTDIR)$(SHAREDIR)/backup/drivers
	cp -r drivers $(DESTDIR)$(SHAREDIR)/backup/drivers
