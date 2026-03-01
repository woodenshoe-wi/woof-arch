CC ?= gcc
STRIP ?= strip
#CC = musl-gcc
STATIC = -static

VPATH = ../../src

all: debdb2pupdb \
	find_cat \
	findpkgs-dep-helper \
	findpkgs-search-helper \
	pup_event_frontend_d \
	vercmp

debdb2pupdb: debdb2pupdb.c
	$(CC) $(STATIC) -O3 -fomit-frame-pointer -ffunction-sections -fdata-sections -fmerge-all-constants -Wl,--sort-common -Wl,-gc-sections -c $< -o $@
	$(STRIP) $@

find_cat: find_cat.c
	$(CC) $(STATIC) -O3 -fomit-frame-pointer -ffunction-sections -fdata-sections -fmerge-all-constants -Wl,--sort-common -Wl,-gc-sections -c $< -o $@
	$(STRIP) $@

findpkgs-dep-helper: findpkgs-dep-helper.c
	$(CC) $(STATIC) -O3 -fomit-frame-pointer -ffunction-sections -fdata-sections -fmerge-all-constants -Wl,--sort-common -Wl,-gc-sections -c $< -o $@
	$(STRIP) $@

findpkgs-search-helper: findpkgs-search-helper.c
	$(CC) $(STATIC) -O3 -fomit-frame-pointer -ffunction-sections -fdata-sections -fmerge-all-constants -Wl,--sort-common -Wl,-gc-sections -c $< -o $@
	$(STRIP) $@

pup_event_frontend_d: pup_event_frontend_d.c
	$(CC) $(STATIC) -O3 -fomit-frame-pointer -ffunction-sections -fdata-sections -fmerge-all-constants -Wl,--sort-common -Wl,-gc-sections -c $< -o $@
	$(STRIP) $@

vercmp: vercmp.c
	$(CC) $(STATIC) -O3 -fomit-frame-pointer -ffunction-sections -fdata-sections -fmerge-all-constants -Wl,--sort-common -Wl,-gc-sections -c $< -o $@
	$(STRIP) $@

clean:
	rm -f debdb2pupdb find_cat findpkgs-dep-helper findpkgs-search-helper vercmp pup_event_frontend_d
